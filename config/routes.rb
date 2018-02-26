Rails.application.routes.draw do
  root to: 'pages#index'

  get '/', to: 'pages#index', as: :pages
  get '(*path)/add', to: 'pages#new', as: :new_page
  get '(*path)/edit', to: 'pages#edit', as: :edit_page

  patch '(*path)', to: 'pages#update', as: :page
  put '(*path)', to: 'pages#update'
  post '(*path)', to: 'pages#create' 
  get '*path', to: 'pages#show'
  delete '*path', to: 'pages#destroy', as: :destroy_path
end
