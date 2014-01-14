
AutomationRails::Application.routes.draw do



  resources :snmps  do
    member do
      get :csv
      post :upload
      post :off
    end
  end

  resources :roadrunners  do
    member do
      get :execute
      post :execute2
    end
    collection do
      get :scripts
    end
  end

  resources :machines  do
    collection do
      get :download
    end
  end

  resources :tags do
    collection  do
      post :execute
      get :save
    end
  end


  resources :features    do
    member do
      get :execute
      get :report
      get :save
      get :machine
      post :multiple_execute
      post :remote_execute
    end
    collection do
      get :search
    end
  end




  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  #命名路由Named Routes可以幫助我們產生URL helper如meetings_url或meetings_path，而不需要用{:controller => 'meetings', :action => 'index'}的方式：
  # match '/meetings' => 'events#index', :as => "meetings"
  #其中:as的部份就會產生一個meetings_path和meetings_url的Helpers，_path和_url的差別在於前者是相對路徑，後者是絕對路徑。一般來說比較常用_path方法，除非像是在Email信件中，才必須用_url提供包含Domain的完整網址。
  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)



  #可以透過 :via 參數指定 HTTP Verb 動詞
  #match "account/overview" => "account#overview", :via => "get"
  #match "account/setup" => "account#setup", :via => [:get, :post]
  #或是
  #get "account/overview" => "account#overview"
  #get "account/setup" => "account#setup"
  #post "account/setup" => "account#setup"


  #特殊條件限定
  #我們可以利用:constraints設定一些參數限制，例如限制:id必須是整數。
  #match "/events/show/:id" => "events#show", :constraints => {:id => /\d/}
  #另外也可以限定IP位置：
  #constraints(:ip => /(^127.0.0.1$)|(^192.168.[0-9]{1,3}.[0-9]{1,3}$)/) do
  #  match "/events/show/:id" => "events#show"
  #end



  #-------------------------------Resource-------------------------------

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  # 一般的资源
  #   resources :products


  # Sample resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  # 会产生short_product_path(@product)和toggle_product_path(@product) /products/123/short和/products/123/toggle  = =>:member
  #     collection do
  #       get 'sold'
  #     end
  # 会产生short_products_path products/short
  #   end

  # Nested Resource 當一個Resource一定會依存另一個Resource時，我們可以套疊多層的Resources
  # 如此產生的URL Helper如product_comment_path(@product)和product_comment_path(@product, @comment)，它的網址會如products/123/comments和products/123/comments/123
  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end


  #命名空间 产生
  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  #----------------------------------------------------------------------

  # 定制首页
  # You can have the root of your site routed with "root"
  # just remember to delete public/No_index.html.
   root :to => 'features#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # 这是个典型路由
   match ':controller(/:action(/:id))(.:format)'


end
