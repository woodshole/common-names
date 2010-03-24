class AddLanguageIdToUser < ActiveRecord::Migration
  def self.up
    add_column :users, :language_id, :integer
  end

  def self.down
    drop_column :users, :language_id
  end
end
