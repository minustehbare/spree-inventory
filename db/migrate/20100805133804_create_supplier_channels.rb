class CreateSupplierChannels < ActiveRecord::Migration
  def self.up
    create_table :supplier_channels do |t|
      t.column :product_id, :integer
      t.column :supplier_id, :integer
      t.column :cost, :decimal, :precision => 8, :scale => 2, :null => false
      t.column :supplier_sku, :string
      t.boolean :is_default
      t.timestamps
    end
  end

  def self.down
    drop_table :supplier_channels
  end
end
