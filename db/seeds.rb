require 'db/seed_methods'
include SeedMethods

def rebuild_lineages
  sql = ActiveRecord::Base.connection();
	sql.begin_db_transaction
	
  # Clear all lineage_ids
  puts "** Clearing existing lineage data..."
  sql.execute "UPDATE taxa SET lineage_ids = NULL;"
  puts "success"
  
  Taxon.rebuild_lineages!
  
  puts  "success: #{Taxon.count} taxa set"
  sql.commit_db_transaction
end
