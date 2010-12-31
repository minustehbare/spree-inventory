class AddReorderColumnsToVariants < ActiveRecord::Migration
  def self.up
    add_column :variants, :reorder_automatically, :boolean
    add_column :variants, :minimum_on_hand, :integer
    add_column :variants, :minimum_reorder_size, :integer
    add_column :variants, :reorder_method, :string
  end

  def self.down
    remove_column :variants, :reorder_automatically
    remove_column :variants, :minimum_on_hand
    remove_column :variants, :minimum_reorder_size
    remove_column :variants, :reorder_method
  end
end
