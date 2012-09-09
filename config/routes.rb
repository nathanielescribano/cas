Cas::Application.routes.draw do
  root :to => "pages#index"
  get 'pages/search'
  get 'pages/restart'
end
