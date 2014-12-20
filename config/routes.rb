# Plugin's routes
# See: http://guides.rubyonrails.org/routing.html
#post 'tm_tables', :to => 'tm_tables#create'
#get 'tm_tables', :to => 'tm_tables#index'
#get 'tm_tables/new', :to => 'tm_tables#new' , :as => "new_tm_table"
#get 'tm_tables/:id', :to => 'tm_tables#show' #, :as => :show
Rails.application.routes.draw do
  resources :projects do
    resources :tm_tables do
	    member do
	      get 'getgentext'
	      get 'getlocaleyml'
	      get 'commit'
	    end
	  end
  end
end