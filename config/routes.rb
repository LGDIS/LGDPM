Lgdpm::Application.routes.draw do
  
  devise_for :users, :controllers => { :sessions => 'users', :omniauth_callbacks => 'omniauth_callbacks', :registrations => 'registrations' }
  
  root :to => 'evacuees#index'
  
  match "evacuees/index"       => "evacuees#index",       :via => :get
  match "evacuees/search"      => "evacuees#search",      :via => :get
  match "evacuees/search"      => "evacuees#search",      :via => :post
  match "evacuees/new"         => "evacuees#new",         :via => :get
  match "evacuees"             => "evacuees#create",      :via => :post
  match "evacuees/:id/edit"    => "evacuees#edit",        :via => :get, :as => "evacuees_edit"
  match "evacuees/:id"         => "evacuees#update",      :via => :put
  
  match "jukis/index"          => "jukis#index",          :via => :get
  match "jukis/import"         => "jukis#import",         :via => :post
  
  match "autocomplete/city"   => "application#autocomplete_city",   :via => :get
  match "autocomplete/street" => "application#autocomplete_street", :via => :get
  
  match "shelters"            => "application#shelters", :via => :get
  match "address"             => "application#address" , :via => :get
  match "master"              => "application#master"  , :via => :get
  
  mount Resque::Server, at: "/resque"
end
