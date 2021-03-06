class VariantLocation < ActiveRecord::Base
  belongs_to :warehouse_location
  belongs_to :variant
  
  def full_location_string(joiner = " >> ")
    warehouse_location.full_location_string(joiner)
  end

end
