Rails.application.routes.draw do
  resources :posts do
    resources :comments
  end

  # i can replace all the routes for pages with: resources :pages
  get '/pages', to: 'pages#index'
  post '/pages', to: 'pages#create'
  get '/pages/new', to: 'pages#new', as: 'new_page'
  get '/pages/:id', to: 'pages#show', as: 'page'
  get '/pages/:id/edit', to: 'pages#edit', as: 'edit_page'
  patch '/pages/:id', to: 'pages#update'
  delete '/pages/:id', to: 'pages#destroy', as: 'delete_page'
end
