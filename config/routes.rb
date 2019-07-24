Rails.application.routes.draw do
  devise_for :users
  root 'users#top'
  resources :books, only:[:new, :create, :index, :show, :edit, :update, :destroy]
  resources :users, only:[:create, :index, :show, :edit, :update]
  get 'home/about' => 'home#about'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
