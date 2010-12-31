class Admin::SuppliersController < Admin::BaseController
  resource_controller


private  
  def collection
    base_scope = end_of_association_chain

    @search = base_scope.searchlogic(params[:search])
    @search.order ||= "ascend_by_name"

    @collection = @search.paginate(:per_page  => 20,
                                   :page      => params[:page])

  end

end
