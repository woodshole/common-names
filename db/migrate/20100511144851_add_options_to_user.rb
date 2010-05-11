class AddOptionsToUser < ActiveRecord::Migration
  def self.up
    add_column :users, :options, :text
  end

  def self.down
    remove_column :users, :options
  end
end
