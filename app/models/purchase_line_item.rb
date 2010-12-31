class PurchaseLineItem < ActiveRecord::Base
  before_validation :adjust_qty
  belongs_to :purchase_order
  belongs_to :variant

  has_one :product, :through => :variant

  #before_validation :copy_price
  before_destroy :ensure_not_shipped

  validates_presence_of :variant, :purchase_order
  validates_numericality_of :qty, :only_integer => true, :message => I18n.t("validation.must_be_int")
  validates_numericality_of :cost

  #attr_accessible :qty, :variant_id, :purchase_order_id

  def copy_price
    self.cost = variant.price if variant && self.cost.nil?
  end

  def validate
    unless qty && qty >= 0
      errors.add(:qty, I18n.t("validation.must_be_non_negative"))
    end

    #if shipped_count = purchase_order.shipped_units.nil? ? nil : purchase_order.shipped_units[variant]
    #  errors.add(:qty, I18n.t("validation.cannot_be_less_than_shipped_units") ) if qty < shipped_count
    #end
  end

  def increment_quantity
    self.qty += 1
  end

  def decrement_quantity
    self.qty -= 1
  end

  def total
    self.cost * self.qty
  end
  alias amount total

  def adjust_qty
    self.qty = 0 if self.qty.nil? || self.qty < 0
  end

  private
  def ensure_not_shipped
#    if shipped_count = purchase_order.shipped_units.nil? ? nil : purchase_order.shipped_units[variant]
#      errors.add_to_base I18n.t("cannot_destory_line_item_as_inventory_units_have_shipped")
#      return false
#    end
  end
end

