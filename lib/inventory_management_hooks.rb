class InventoryManagementHooks < Spree::ThemeSupport::HookListener
  # custom hooks go here
  insert_after :admin_tabs do
    %(<%= tab(:purchase_orders) %>)    
  end
  insert_after :admin_tabs do
    %(<%= tab(:warehouses) %>)    
  end
end
