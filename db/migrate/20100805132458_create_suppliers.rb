class CreateSuppliers < ActiveRecord::Migration
  def self.up
    create_table :suppliers do |t|
      t.column :name, :string
      t.column :address1, :string
      t.column :address2, :string
      t.column :city, :string
      t.column :state, :string
      t.column :zip, :string
      t.column :phone, :string
      t.column :fax, :string
      t.column :email, :string
      t.timestamps
    end
  end

  def self.down
    drop_table :suppliers
  end
end
