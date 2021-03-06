require 'db/seed_methods'
include SeedMethods

TAXA = "nubHigherTaxa/taxa.txt"
VERNACULAR = "nubHigherTaxa/vernacular.txt"
LANGUAGES = "languages.txt"

RANKS = {
          "kingdom"   => 0,
          "phylum"    => 1,
          "class"     => 2,
          "order"     => 3,
          "family"    => 4,
          # destroy subfamily idea, we aren't using it
          "subfamily" => 4
        }

@log = Logger.new(STDOUT)

# Recreate left and right values for every taxon
def reload_nested_sets
  @log.info "** Reload Nested Sets"
  Taxon.rebuild!
end

# Redo the left and right fields for every single taxon. SLOW! RUN WITH CAUTION!
def rebuild_lineages
  @log.info "** Rebuild Lineages"
  Taxon.transaction {Taxon.rebuild_lineages!}
end

# Destroy all languages. Uses a TRUNCATE command on the table, cause it's fast.
def destroy_all_languages
  @log.info "** Destroy Languages"
  ActiveRecord::Base.connection.execute "TRUNCATE languages;"
end

# Destroy all taxa. Uses a TRUNCATE command on the table, cause it's fast.
def destroy_all_taxa
  @log.info "** Destroy Taxa"
  ActiveRecord::Base.connection.execute "TRUNCATE taxa;"
end

# Destroy all names that belong to gbif. Ensures we don't have duplicate data
def destroy_gbif_names
  @log.info "** Destroy GBIF's Common Names"
  CommonName.destroy_all(:user_id => nil)
end

# Create the 'UBT' taxon that all kingdoms should belong to. This must exist for nested sets to work.
def create_root_taxon
  taxon = Taxon.new(:name => 'UBT', :rank => -1, :parent_id => nil)
  taxon.id = 1
  taxon.send(:create_without_callbacks)
end

# Given a line from the taxa file (and an incrementor for debugging), create a taxon.
def create_taxon_from_line(taxon_line, i)
  id, name, rank_name, parent_id = taxon_line.split("\t")
  
  # If it's a kingdom, GBIF doesn't supply a parent_id, so we set one here.
  if rank_name == "kingdom" && parent_id.blank?
    parent_id = 0
  end
  
  # Make sure data line is valid.
  if id.blank? || name.blank? || rank_name.blank? || parent_id.blank?
    @log.error "Broken line at #{i}: #{taxon_line}"
  end

  # Convert ranks into rank ids.
  rank = RANKS[rank_name]
  if rank.nil?
    @log.error "Unknown rank #{rank_name}. Taxon not saved!"
    break
  end

  # Create the actual taxon.
  taxon = Taxon.new(:name => name, :rank => rank)
  taxon.id = id.to_i + 1
  taxon.parent_id = parent_id.to_i + 1
  taxon.send(:create_without_callbacks)
end

# Given a line from the vernacular file (and an incrementor for debugging),
# create a common name. There's some additional logic here from what you
# see in the taxa seed methods because we don't delete existing data.
def create_common_name_from_line(common_name_line, i)
  taxon_id, name, iso_code, bad1, bad2, bad3 = common_name_line.split("\t")
  
  # Make sure data line is valid.
  if taxon_id.blank? || name.blank? || iso_code.blank?
    # This line is sloppy because a lot of these lines don't have a language attached.
    # @log.error "Broken line at #{i}: #{common_name_line}"
  else    
    # Some cleanup.
    name = name.titleize
    iso_code.upcase!
    taxon_id = taxon_id.to_i + 1
  
    # Look for extra data. What are all of the additional tabs on the vernacular file for? I don't know!
    unless bad1.blank? && bad2.blank? && bad3.blank?
      @log.error "Weird data at #{i}: #{common_name_line}"
    end
    
    # Find the appropriate language by iso code.
    language = Language.find_by_iso_code(iso_code.downcase)
    if language.nil?
      @log.error "Unknown language by iso code: #{iso_code}"
    else
      # Create the actual taxon.
      common_name = CommonName.new(:taxon_id => taxon_id, :name => name, :language => language, :source => "GBIF")
      # I don't force this save to raise, because some names are duplicates in GBIF's data
      common_name.save
    end
  end
end


# A UTF-8 database connection is required for the native languages to import properly.
def ensure_database_is_utf8
  ar_config = ActiveRecord::Base.configurations
  
  unless ar_config[Rails.env]['encoding'] == 'utf8'
    
    new_database_yaml = ar_config.clone
    new_database_yaml.each{|env, config| config['encoding'] = 'utf8'} # Add the utf8 encoding to every environment in database.yml
    
    @log.error "Your database connection's character set is not set to UTF-8.\n" +
               "This is required for native languages to import correctly.\n\n" + 
               "To fix this problem, open config/database.yml and ensure that each\n" + 
               "connection contains the line 'encoding: utf8' like so:\n" +
               new_database_yaml.to_yaml

    exit
  end
end

# Load languages into Database
def import_languages
  ensure_database_is_utf8

  path = File.join(Rails.root, "db/data", LANGUAGES)
  File.open(path, 'r') do |languages|
    if languages.nil?
      @log.error "Languages file not found"
      exit
    end
    num_lines = get_num_lines(path)
  
    Language.transaction do
      destroy_all_languages
      
      progress("Load Languages", num_lines) do |progress_bar|
        i = 1
        languages.each_line do |languageline|
          next if languageline.starts_with?('#') # Allow comments in datafile
        
          iso_code, english_name, native_name = languageline.rstrip.split("\t")
        
          Language.create(:iso_code => iso_code, :english_name => english_name, :native_name => native_name)
        
          progress_bar.inc
          i += 1
        end
      end
    end
  end
end

def import_gbif_taxa
  path = File.join(Rails.root, "db/data", TAXA)
  File.open(path, 'r') do |taxa|
    if taxa.nil?
      @log.error "Taxa file not found"
      exit
    end
    num_lines = get_num_lines(path)
  
    Taxon.transaction do
      destroy_all_taxa
      
      create_root_taxon
      
      # Load all taxa from GBIF here.
      progress("GBIF Taxa", num_lines) do |progress_bar|
        i = 1 # incrementor, to see what line we're on
        taxa.each_line do |taxon_line|
          create_taxon_from_line(taxon_line, i)
          progress_bar.inc
          i += 1
        end
      
      end
      
      reload_nested_sets
      rebuild_lineages
    end
  end
  
end

def import_gbif_vernacular
  path = File.join(Rails.root, "db/data", VERNACULAR)
  File.open(path, 'r') do |common_names|
    if common_names.nil?
      @log.error "Vernacular file not found"
      exit
    end
    num_lines = get_num_lines(path)
  
    CommonName.transaction do
      destroy_gbif_names
      
      # Load all taxa from GBIF here.
      progress("GBIF Names", num_lines) do |progress_bar|
        i = 1 # incrementor, to see what line we're on
        common_names.each_line do |common_name_line|
          create_common_name_from_line(common_name_line, i)
          progress_bar.inc
          i += 1
        end
      
      end
    end
  end
end

import_languages
import_gbif_taxa
import_gbif_vernacular