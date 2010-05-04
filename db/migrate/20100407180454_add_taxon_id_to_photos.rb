class AddTaxonIdToPhotos < ActiveRecord::Migration
  def self.up
    add_column :photos, :taxon_id, :integer
  end

  def self.down
    remove_column :photos, :taxon_id
  end
end
