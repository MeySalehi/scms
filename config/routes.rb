Rails.application.routes.draw do

	namespace :admin do

    get   "/login"  => 'dashboard#login'
    post  "/login"  => 'dashboard#attempt_login'
    get   "/logout" => 'dashboard#logout'
    
    resources :dashboard, only:[:index, :draft] do
      collection do
        post "" => :draft
      end
    end
		
    resources :posts do
			collection do
				get "page/:id(.:format)" => :index
			end
			resources :comments
		end
    resources :pages do
      collection do
        get "page/:id(.:format)" => :index
      end
      resources :comments
    end
		resources :settings do
			collection do
				resources :authors
			end
		end
		resources :comments do
			collection do
				get "page/:id(.:format)" => :index
			end
		end
		resources :caregories  do
			collection do
				get "page/:id(.:format)" => :index
			end
		end
    resources :uploads do
      collection do
        get "page/:id(.:format)" => :index
      end
    end
	end

	resources :posts, param: :permalink, only: [:index, :show] do
		collection do
			get "page/:id(.:format)" => :page
			get "search/:query(/page/:id(.:format))" => :search
			get "category/:title(/page/:id(.:format))" => :category
		end
    member do
      post :comment
    end
	end

	resources :authors, only: [:index] do
		collection do
			get "page/:id(.:format)" => :page
		end
	end

  resources :files, only: :show

	get	'@:username(.:format)'	=> 'authors#profile'
  get ':permalink(.:format)' => 'posts#show_page'
	root 'posts#index'
  

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
