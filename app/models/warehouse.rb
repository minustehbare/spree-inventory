class Warehouse < ActiveRecord::Base
  has_many :warehouse_locations, :dependent => :destroy
  has_one :root, :class_name => 'WarehouseLocation', :conditions => "parent_id is null"
end
