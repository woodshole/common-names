class CreateCommonNames < ActiveRecord::Migration
  def self.up
    create_table :common_names do |t|
      t.string :name
      t.integer :taxon_id

      t.timestamps
    end
  end

  def self.down
    drop_table :common_names
  end
end
