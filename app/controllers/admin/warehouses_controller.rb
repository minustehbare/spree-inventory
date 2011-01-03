class Admin::WarehousesController < Admin::BaseController
  #modeled after the taxonomies_controller located here: https://github.com/railsdog/spree/blob/master/core/app/controllers/admin/taxonomies_controller.rb
  #touch up needed
  resource_controller
  before_filter :load_data, :only => [:create, :update]
  
  new.response do |wants|
    wants.html
    wants.js do
      render :partial => new.html.erb
    end
  end
  
  edit.response do |wants|
    wants.html
    wants.js do
      render :partial => 'edit.html.erb'
    end
  end
  
  def collection
    @collection = Warehouse.all
  end
end
