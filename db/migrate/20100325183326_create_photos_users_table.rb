class CreatePhotosUsersTable < ActiveRecord::Migration
  def self.up
    create_table :photos_users, :id => false do |t|
      t.references :photo, :user
    end
  end

  def self.down
    drop_table :photos_users
  end
end
