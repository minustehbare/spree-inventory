class CreateWarehouses < ActiveRecord::Migration
  def self.up
    create_table :warehouses do |t|
      t.column :name, :string
      t.column :address1, :string
      t.column :address2, :string
      t.column :city, :string
      t.column :state, :string
      t.column :zip, :string
      t.timestamps
    end
  end

  def self.down
    drop_table :warehouses
  end
end
