class AddLanguageIdToUser < ActiveRecord::Migration
  def self.up
    add_column :users, :language_id, :integer, :default => Language.find_by_english_name('english').id
  end

  def self.down
    remove_column :users, :language_id
  end
end
