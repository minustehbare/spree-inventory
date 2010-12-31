require 'spree_core'
require 'inventory_management_hooks'

module InventoryManagement
  class Engine < Rails::Engine

    config.autoload_paths += %W(#{config.root}/lib)

    def self.activate
      Dir.glob(File.join(File.dirname(__FILE__), "../app/**/*_decorator*.rb")) do |c|
        Rails.env.production? ? require(c) : load(c)
      end
      
      Admin::ProductsController.class_eval do
        def products_by_supplier

          includes = [{:variants => :images}, :master, :images]
          @collection = Product.name_contains(params[:q]).supplier_channels_supplier_id_eq(params[:supplier_id]).all(:include => includes, :limit => 10)
                
          respond_to do |wants|
            wants.json {
              render :json => @collection.to_json(:include => {:master => {}, :variants => {:include => {:images => {}}}, :images => {}})
              }
          end
        end
      end
      
      Variant.class_eval do
        has_many :variant_locations, :dependent => :destroy
        has_many :supplier_channels
        has_many :suppliers, :through => :supplier_channels
        
        has_one :default_supplier_channel, :class_name => "SupplierChannel", :conditions => "supplier_channels.is_default = 1"
        has_one :default_supplier, :class_name => "Supplier", :through => :default_supplier_channel
        
        def cost_price 
          default_supplier_channel.cost if default_supplier_channel
        end
      end
    
      Order.class_eval do
    
        state_machine do
          after_transition :to => 'paid', :do => [:make_shipments_ready, :check_if_reorder_needed]
        end
      
        def check_if_reorder_needed
          PurchaseOrder.check_if_reorder_needed(products)
        end
      
      end
      
    end

    config.to_prepare &method(:activate).to_proc
  end
end
