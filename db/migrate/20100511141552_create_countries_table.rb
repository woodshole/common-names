class CreateCountriesTable < ActiveRecord::Migration
  def self.up
    create_table :countries do |table|
      table.column :name, :string
      table.column :iso_code, :string
    end
  end

  def self.down
    drop_table :countries
  end
end
