class PurchaseOrder < ActiveRecord::Base
  module Totaling
    def total
      map(&:amount).sum
    end
  end

  before_create :generate_order_number

  belongs_to :supplier
  has_many :state_events, :as => :stateful
  has_many :purchase_line_items, :extend => Totaling, :dependent => :destroy
  
  make_permalink :field => :number
  
  accepts_nested_attributes_for :purchase_line_items
  
  state_machine :initial => 'in_progress' do
    after_transition :to => 'sent', :do => :send_purchase_order
 
    event :send_out do
      transition :to => 'sent', :from  => 'in_progress'
    end
    event :receive do
      transition :to => 'received', :from  => 'sent'
    end
  end
  
  def send_purchase_order
    logger.info("TODO: Send out the purchase order")
  end

  def contains?(variant)
    purchase_line_items.select { |purchase_line_item| purchase_line_item.variant == variant }.first
  end

  def add_variant(variant, quantity=1)
    current_item = contains?(variant)
    if current_item
      current_item.increment_quantity unless quantity > 1
      current_item.quantity = (current_item.quantity + quantity) if quantity > 1
      current_item.save
    else
      current_item = PurchaseLineItem.new(:qty => quantity)
      current_item.variant = variant
      current_item.cost   = variant.price
      self.purchase_line_items << current_item
    end

    current_item
  end
  
  def update_totals
    self.purchase_line_items.map(&:save)
    self.total  = self.purchase_line_items.total
  end
   
  def to_param
    self.number if self.number
    generate_order_number unless self.number
    self.number.parameterize.to_s.upcase
  end
  
  def generate_order_number
    record = true
    while record
      random = "S#{Array.new(9){rand(9)}.join}"
      record = PurchaseOrder.find(:first, :conditions => ["number = ?", random])
    end
    self.number = random
  end
  
  def self.check_if_reorder_needed(variants)
    variants.each do |v| determine_reorder_method(v) if v.reorder_automatically
    end
  end
  
  def self.determine_reorder_method(variant)
    qty = if variant.reorder_method == 'fixed' 
      variant.minimum_reorder_size
    elsif variant.reorder_method == 'delta'
      variant.minimum_on_hand - variant.count_on_hand
    end
    order_more_of(variant, qty)
  end
  
  def self.order_more_of(variant, qty)
    purchase_order = PurchaseOrder.find_or_create_by_supplier_and_status(variant.default_supplier, 'in_progress')
    purchase_order.add_variant(variant, qty)
  end

end
