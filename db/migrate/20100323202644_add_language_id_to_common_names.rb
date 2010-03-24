class AddLanguageIdToCommonNames < ActiveRecord::Migration
  def self.up
    add_column :common_names, :language_id, :integer
  end

  def self.down
    remove_column :common_names, :language_id
  end
end
