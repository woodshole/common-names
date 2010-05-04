class AddSourceToCommonNames < ActiveRecord::Migration
  def self.up
    add_column :common_names, :source, :string
  end

  def self.down
    remove_column :common_names, :source
  end
end
