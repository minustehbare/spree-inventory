class SupplierChannel < ActiveRecord::Base
  before_validation :guess_values
  before_save :demote_existing_default

  validates_presence_of :variant, :supplier, :cost, :supplier_sku
  validates_uniqueness_of :supplier_id, :scope => [:variant_id]
  validates_numericality_of :cost, :greater_than => 0.0

  belongs_to :variant
  belongs_to :supplier

  def guess_values
    self.supplier_sku = variant.sku if self.supplier_sku.blank?
  end
  
  def demote_existing_default
    variant.supplier_channels.each{|x| x.update_attribute(:is_default, false)} if self.is_default
    true
  end

end
