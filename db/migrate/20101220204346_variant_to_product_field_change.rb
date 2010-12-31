class VariantToProductFieldChange < ActiveRecord::Migration
  def self.up
    rename_column :purchase_line_items, :variant_id, :product_id
  end

  def self.down
    rename_column :purchase_line_items, :product_id, :variant_id
  end
end
