class RenameProductLocationsTableAndColumns < ActiveRecord::Migration
  def self.up
    rename_table :product_locations, :variant_locations
    rename_column :variant_locations, :product_id, :variant_id
  end

  def self.down
    rename_table :variant_locations, :product_locations
    rename_column :product_locations, :variant_id, :product_id
  end
end
