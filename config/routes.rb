require 'sidekiq/web' #sidekiq GUI

Antho::Application.routes.draw do

  resources :articles


  get "evangelists/index"

  resources :search_suggestions  
  resources :loves
  resources :password_resets
  resources :invites  



  resources :friends, :controller => "friendships", :except => [:show, :edit] do
      get "requests", :on => :collection
      get "invites", :on => :collection
  end

  resources :microposts do 
    resources :comments, :only => [:create, :destroy, :show, :index]

    member do
      get :show, :lovers, :loving, :loves, :show_lovers
    end
  end

  resources :users do
    member do
       get :show_posts, :other_user_index, :anthologies_managed #:following, :followers: kinships, 
     end
  end

  #resources :randybird do
    #member do
        #get :themes
    #end
  #end
  #an idea -- generate new models everytime we have a new client -- this looks like it'll congest the app more than simple view pages...

  resources :evangelists
  resources :subjects
  resources :sessions, only: [:new, :create, :destroy]

  root to: 'static_pages#home'

  match '/start',   to: 'users#new'
  match '/contribute', to: 'microposts#new'
  match '/signin',   to: 'sessions#new'
  match '/signout',  to: 'sessions#destroy', via: :delete

  match '/randybird', to: 'static_pages#randybird'
  match '/randybird_provide', to: 'static_pages#randy_provide'
  match '/randybird_protect', to: 'static_pages#randy_protect'
  match '/randybird_preside', to: 'static_pages#randy_preside'
  match '/randybird_courtship', to: 'static_pages#randy_courtship'
  match '/randybird_boyhood', to: 'static_pages#randy_childhood'
  match '/randybird_formative_years', to: 'static_pages#randy_formative_years'
  match '/randybird_early_adulthood', to: 'static_pages#randy_early_adulthood'
  match '/randybird_guestbook', to: 'static_pages#randy_guestbook'
  match '/randybird_timeline', to: 'static_pages#randy_timeline'
  match '/randybird_adventure', to: 'static_pages#randy_adventure'
  match '/randybird_family_tree', to: 'static_pages#randy_family_tree'

  match '/salmon_family', to: 'static_pages#salmon_family'
  match '/salmon_perseverance', to: 'static_pages#salmon_perseverance'
  match '/salmon_love_story', to: 'static_pages#salmon_love_story'
  match '/salmon', to: 'static_pages#salmon'
  match '/salmon_timeline', to: 'static_pages#salmon_timeline'
  match '/salmon_guestbook', to: 'static_pages#salmon_guestbook'
  match '/salmon_hobbies', to: 'static_pages#salmon_hobbies'
  match '/salmon_service', to: 'static_pages#salmon_service'
  match '/salmon_family_tree', to: 'static_pages#salmon_family_tree'
  match '/salmon_zoom', to: 'static_pages#zoomed_in_salmon'

  match '/li', to: 'static_pages#li'
  match '/li_progress_one', to: 'static_pages#li_progress_one.html.erb'
  match '/li_progress_two', to: 'static_pages#li_progress_two.html.erb' 
  match '/li_progress_three', to: 'static_pages#li_progress_three.html.erb' 
  match '/li_grace', to: 'static_pages#li_grace.html.erb' 
  match '/li_spirituality', to: 'static_pages#li_spirituality.html.erb' 
  match '/li_timeline', to: 'static_pages#li_timeline.html.erb' 
  match '/li_family_tree', to: 'static_pages#li_family_tree.html.erb' 
  match '/li_guestbook', to: 'static_pages#li_guestbook.html.erb'
  match '/li_test', to: 'static_pages#li_test.html.erb'

  match '/evelyn', to: 'static_pages#evelyn'
  match '/evelyn_hardship', to: 'static_pages#evelyn_hardship'
  match '/evelyn_faith', to: 'static_pages#evelyn_faith'
  match '/evelyn_motherhood_1', to: 'static_pages#evelyn_motherhood_1'
  match '/evelyn_purpose', to: 'static_pages#evelyn_purpose'
  match '/evelyn_motherhood_2', to: 'static_pages#evelyn_motherhood_2'
  match '/evelyn_descendants', to: 'static_pages#evelyn_descendants'
  match '/evelyn_family_tree', to: 'static_pages#evelyn_family_tree'
  match '/evelyn_timeline', to: 'static_pages#evelyn_timeline'
  match '/evelyn_guestbook', to: 'static_pages#evelyn_guestbook'

  match '/carma', to: 'static_pages#carma'
  match '/carma_farmer_and_nurse_1', to: 'static_pages#carma_farmer_and_nurse_1'
  match '/carma_farmer_and_nurse_2', to: 'static_pages#carma_farmer_and_nurse_2'
  match '/carma_missionary_service_1', to: 'static_pages#carma_missionary_service_1'
  match '/carma_missionary_service_2', to: 'static_pages#carma_missionary_service_2'
  match '/carma_i_can_do_hard_1', to: 'static_pages#carma_i_can_do_hard_1'
  match '/carma_i_can_do_hard_2', to: 'static_pages#carma_i_can_do_hard_2'
  match '/carma_chocolate', to: 'static_pages#carma_chocolate'
  match '/carma_annex', to: 'static_pages#carma_annex'
  match '/carma_childhood_1', to: 'static_pages#carma_childhood_1'
  match '/carma_childhood_2', to: 'static_pages#carma_childhood_2'
  match '/carma_the_farm', to: 'static_pages#carma_the_farm'
  match '/carma_town_living', to: 'static_pages#carma_town_living'
  match '/carma_guestbook', to: 'static_pages#carma_guestbook'
  match '/carma_timeline', to: 'static_pages#carma_timeline'

  match '/roos', to: 'static_pages#roos'
  match '/roos_service', to: 'static_pages#roos_service'
  match '/roos_resilience', to: 'static_pages#roos_resilience'
  match '/roos_wisdom', to: 'static_pages#roos_wisdom'
  match '/roos_devotion', to: 'static_pages#roos_devotion'
  match '/roos_conversion', to: 'static_pages#roos_conversion'
  match '/roos_bills_childhood', to: 'static_pages#roos_bills_childhood'
  match '/roos_teresas_childhood', to: 'static_pages#roos_teresas_childhood'
  match '/roos_annex', to: 'static_pages#roos_annex'
  match '/roos_the_army', to: 'static_pages#roos_the_army'
  match '/roos_guestbook', to: 'static_pages#roos_guestbook'
  match '/roos_timeline', to: 'static_pages#roos_timeline'

  match '/test', to: 'static_pages#test_video'
  match '/testingx', to: 'static_pages#testing'

  match '/michelle', to: 'static_pages#michelle_nielsen'

  match '/help',    to: 'static_pages#help'
  match '/about',   to: 'static_pages#about'
  match '/contact', to: 'evangelists#new'
  match '/jobs',    to: 'static_pages#jobs'
  #match '/blog',   to: 'static_pages#blog'
  match '/blog',   to: 'articles#index'
  match '/drafts', to: 'articles#drafts'

  match '/method', to: 'static_pages#method'
  match '/mission', to: 'static_pages#mission'
  match '/anthologies', to: 'users#index'
  match '/requests', to: 'friendships#requests'
  match '/story_ticker', to: 'users#story_ticker'
  match '/self', to: 'users#self'
  match '/evangelists', to: 'evangelists#index'
  #match '/invite_request', to: 'evangelists#new'
  match '/my_drafts', to: 'microposts#index'
  match '/homepage', to: 'static_pages#test_story'


  mount Sidekiq::Web, at: "/sidekiq" #sidekiq GUI
  mount Ckeditor::Engine => '/ckeditor'

  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
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

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  # root :to => 'welcome#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
