class AddLineageIdsToTaxa < ActiveRecord::Migration
  def self.up
    add_column :taxa, :lineage_ids, :string
  end

  def self.down
    remove_column :taxa, :lineage_ids
  end
end
