class AddUserIdToCommonName < ActiveRecord::Migration
  def self.up
    add_column :common_names, :user_id, :integer
  end

  def self.down
    remove_column :common_names, :user_id
  end
end
