class Admin::PurchaseOrdersController < Admin::BaseController
  resource_controller
    
  before_filter :load_data, :only => [:new, :edit, :create, :update]

  edit.after do
    flash[:error] = "Cannot re-assign Supplier. Delete purchase order and start over."
  end
  
  create.response do |wants|
    wants.html { redirect_to '/admin/purchase_orders/' + @purchase_order.number + '/edit' }
  end
  
  update.after :recalulate_totals, :set_state
  create.after :recalulate_totals
  
  private

  def load_data
    @suppliers = Supplier.all.collect{|x| [x.name, x.id]}
  end

  def collection
    @search = PurchaseOrder.searchlogic(params[:search])
    # The order of the search not Order
    @search.order ||= "descend_by_created_at"

    @collection = @search.paginate(:include  => [:supplier, :purchase_line_items],
                                   :per_page => 30,
                                   :page     => params[:page])
  end
  
  def set_state
    @purchase_order.send(params[:submit]) if params[:submit]
  end
  
  def object
    @object ||= PurchaseOrder.find_by_number(params[:id])
  end

  def recalulate_totals
    @purchase_order.update_totals
  end
  
end
