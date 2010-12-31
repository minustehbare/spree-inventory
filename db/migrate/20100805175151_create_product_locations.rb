class CreateProductLocations < ActiveRecord::Migration
  def self.up
    create_table :product_locations do |t|
      t.column :product_id, :integer
      t.column :warehouse_location_id, :integer
      t.column :count, :integer
      t.column :min_count, :integer
      t.column :source_id, :integer
      t.column :source_type, :string
      t.timestamps
    end
  end

  def self.down
    drop_table :product_locations
  end
end
