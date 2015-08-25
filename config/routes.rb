Rails.application.routes.draw do

  get   "/login"  => 'admin/dashboard#login'
  post  "/login"  => 'admin/dashboard#attempt_login'
  get   "/logout" => 'admin/dashboard#logout'


	namespace :admin do
    root to: redirect('admin/dashboard/')    
    
    resources :dashboard, only:[:index, :draft] do
      collection do
        post "" => :draft
      end
    end
		
    resources :posts do
      resources :comments, except: [:new] do 
        get "answer" => :new, on: :member
      end
      get 'delete', on: :member 
		end
    
    resources :pages do
      resources :comments, except: [:new] do 
        get "answer" => :new, on: :member
      end
      get 'delete', on: :member 
    end
		
    resources :settings
    
    resources :users, param: :username do
      member do
        get "/posts(.:format)" => "posts#index", as: "posts"
        get "/delete" => :delete
      end
    end

		resources :comments, except: [:new] do 
      get "answer" => :new, on: :member
    end
		resources :caregories
    resources :uploads
	end

	resources :posts, param: :permalink, only: [:index, :show] do
		collection do
			get "search/:query(.:format)" => :search, as: 'search'
			get "category/:title(.:format)" => :category
		end
    member do
      post :comment
    end
	end

	resources :authors, only: [:index]

  resources :files, only: :show

	get  '@:username(.:format)'	=> 'authors#profile', as: 'user_profile'
  get  ':permalink(.:format)' => 'posts#show_page', as: 'show_page'
  post ':permalink/comment(.:format)' => 'posts#comment', as: 'comment_page' 
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
