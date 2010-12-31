class SupplierChannel < ActiveRecord::Base
  before_validation :guess_values
  before_save :demote_existing_default

  validates_presence_of :product, :supplier, :cost, :supplier_sku
  validates_uniqueness_of :supplier_id, :scope => [:product_id]
  validates_numericality_of :cost, :greater_than => 0.0

  belongs_to :product
  belongs_to :supplier

  def guess_values
    self.supplier_sku = product.sku if self.supplier_sku.blank?
  end
  
  def demote_existing_default
    product.supplier_channels.each{|x| x.update_attribute(:is_default, false)} if self.is_default
    true
  end

end
