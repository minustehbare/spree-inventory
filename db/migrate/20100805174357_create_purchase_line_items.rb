class CreatePurchaseLineItems < ActiveRecord::Migration
  def self.up
    create_table :purchase_line_items do |t|
      t.column :purchase_order_id, :integer
      t.column :variant_id, :integer
      t.column :qty, :integer
      t.column :cost, :decimal, :precision => 8, :scale => 2, :null => false
      t.timestamps
    end
  end

  def self.down
    drop_table :purchase_line_items
  end
end
