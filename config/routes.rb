Lgdpm::Application.routes.draw do
  
  devise_for :users, :controllers => { :sessions => 'users' }
  
  root :to => 'evacuees#index'
  
  match "evacuees/index"       => "evacuees#index",       :via => :get
  match "evacuees/search"      => "evacuees#search",      :via => :get
  match "evacuees/search"      => "evacuees#search",      :via => :post
  match "evacuees/new"         => "evacuees#new",         :via => :get
  match "evacuees"             => "evacuees#create",      :via => :post
  match "evacuees/:id/edit"    => "evacuees#edit",        :via => :get, :as => "evacuees_edit"
  match "evacuees/:id"         => "evacuees#update",      :via => :put
  match "evacuees/:id/list"    => "evacuees#list",        :via => :get
  match "evacuees/:id/match"   => "evacuees#match",       :via => :post
  
  match "jukis/index"          => "jukis#index",          :via => :get
  match "jukis/import"         => "jukis#import",         :via => :post
  
  match "local_people/index"   => "local_people#index",   :via => :get
  match "local_people/search"  => "local_people#search",  :via => :get
  match "local_people/search"  => "local_people#search",  :via => :post
  
  match "linkages/index"       => "linkages#index",       :via => :get
  match "linkages/search"      => "linkages#search",      :via => :get
  match "linkages/search"      => "linkages#search",      :via => :post
end
