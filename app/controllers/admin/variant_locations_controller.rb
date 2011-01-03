class Admin::ProductLocationsController < Admin::BaseController
  resource_controller
  before_filter :load_data, :only => [:index, :remove]
  belongs_to :product
  
  def remove
    @product.product_locations.delete(params[:id])
    render :layout => false
  end
  
  def finalize
    @product = Product.find_by_permalink(params[:product_id])
    @parent_id = params[:parent_id]
    
    ProductLocation.create(:product_id => @product.id, :warehouse_location_id => @parent_id)
    
  end

  private
  def load_data
    @product = parent_object
  end
  
  def object
    @object ||= Product.find_by_permalink(params[:product_id])
  end
  
  def collection
    @search = end_of_association_chain
    @collection = @search.find(:all, :include => :warehouse_location)
    @possible_locations = WarehouseLocation.parent_id_eq(params[:parent_id] || nil).all
  end
end
