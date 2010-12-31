class CreatePurchaseOrders < ActiveRecord::Migration
  def self.up
    create_table :purchase_orders do |t|
      t.column :number, :string
      t.column :sent_at, :date
      t.column :received_at, :date
      t.column :supplier_id, :integer
      t.column :state, :string
      t.column :item_total, :decimal, :precision => 8, :scale => 2
      t.column :total, :decimal, :precision => 8, :scale => 2
      t.timestamps
    end
  end

  def self.down
    drop_table :purchase_orders
  end
end
