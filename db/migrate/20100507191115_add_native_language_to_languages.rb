class AddNativeLanguageToLanguages < ActiveRecord::Migration
  def self.up
    add_column :languages, :native_name, :string
  end

  def self.down
    remove_column :languages, :native_name
  end
end
