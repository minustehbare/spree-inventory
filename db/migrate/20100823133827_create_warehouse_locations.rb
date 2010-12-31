class CreateWarehouseLocations < ActiveRecord::Migration
  def self.up
    create_table :warehouse_locations do |t|
      t.column :warehouse_id, :integer
      t.column :name, :string
      t.column :parent_id, :integer
    end
  end

  def self.down
    drop_table :warehouse_locations
  end
end
