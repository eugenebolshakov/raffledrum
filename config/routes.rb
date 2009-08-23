ActionController::Routing::Routes.draw do |map|
  map.root :controller => 'home'
  map.resources :my_raffles, :member => { :change_winner => :put }
  map.resources :raffles
  map.about '/about', :controller => 'home', :action => 'about'
end
