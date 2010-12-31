class RenameSupplierChannelsProductColumn < ActiveRecord::Migration
  def self.up
    rename_column :supplier_channels, :product_id, :variant_id
  end

  def self.down
    rename_column :supplier_channels, :variant_id, :product_id
  end
end
