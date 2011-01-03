Rails.application.routes.draw do
  namespace :admin do
    resources :purchase_orders do
      resources :purchase_line_items
    end

    resources :suppliers

    resources :products do
      resources :supplier_channels do
        member do
          get :set_default
        end
      end

      resources :product_locations do
        member do 
          post :remove
        end
      end

      collection do
        get :products_by_supplier
      end
    end

    resources :warehouses do
      resources :warehouse_locations do
        collection do
          get :find_sub_locations
        end
      end
    end
    
  end
end
