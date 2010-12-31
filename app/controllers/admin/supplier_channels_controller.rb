class Admin::SupplierChannelsController < Admin::BaseController
  resource_controller
  belongs_to :product
  
  before_filter :load_data, :only => [:new, :edit, :create, :update]

  new_action.response do |wants|
    wants.html {render :action => :new, :layout => false}
  end

  update.response do |wants|
    wants.html { redirect_to collection_url }
  end
 
  create.response do |wants|
    wants.html { redirect_to collection_url }
  end
  
  def set_default
    supplier_channel = SupplierChannel.find(params[:id])
    supplier_channel.is_default = true
    supplier_channel.save
    redirect_to admin_variant_supplier_channels_url(parent_object)
  end
  
  private

  def load_data
    @suppliers = Supplier.all.collect{|x| [x.name, x.id]}
    @product = parent_object
  end

  def collection
    @search = end_of_association_chain.searchlogic(params[:search])
    @search.order ||= "ascend_by_name"
    
    #@search = end_of_association_chain
    @collection = @search.find(:all, :include => :supplier)
  end

end
