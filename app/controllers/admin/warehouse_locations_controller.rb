class Admin::WarehouseLocationsController < Admin::BaseController
  resource_controller
  before_filter :load_data, :only => [:index, :find_sub_locations]
  
  def find_sub_locations
    render :partial => 'location_finder'
  end
  
  def load_data
    @possible_locations = WarehouseLocation.parent_id_eq(params[:parent_id] || nil).all
  end
  
end
