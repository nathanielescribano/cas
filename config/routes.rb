Cas::Application.routes.draw do
  root :to => "pages#index"
  get 'pages/search'
  get 'pages/add_to_cart'
  get 'pages/restart'
end
