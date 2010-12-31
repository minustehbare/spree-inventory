class WarehouseLocation < ActiveRecord::Base
  belongs_to :warehouse
  belongs_to :parent, :class_name => 'WarehouseLocation'
  has_many :children, :class_name => 'WarehouseLocation', 
           :foreign_key => 'parent_id', 
           :dependent => :destroy
           
  def full_location_string(joiner = " >> ")
    location_names = [self.name]
    object = self
    
    while object.parent
      location_names.unshift object.parent.name
      object = object.parent
    end
    
    location_names.join(joiner)
  end

end
