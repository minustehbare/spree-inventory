class AddReorderColumnsToProducts < ActiveRecord::Migration
  def self.up
    add_column :products, :reorder_automatically, :boolean
    add_column :products, :minimum_on_hand, :integer
    add_column :products, :minimum_reorder_size, :integer
    add_column :products, :reorder_method, :string
  end

  def self.down
    remove_column :products, :reorder_automatically
    remove_column :products, :minimum_on_hand
    remove_column :products, :minimum_reorder_size
    remove_column :products, :reorder_method
  end
end
