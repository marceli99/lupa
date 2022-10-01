Rails.application.routes.draw do
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  post 'cart/checkout', to: 'cart#checkout'
  post 'cart/show', to: 'cart#show'
  post 'cart/add', to: 'cart#add'
  post 'cart/remove', to: 'cart#remove'
  post 'cart/increase_count', to: 'cart#increase_count'
  post 'cart/decrease_count', to: 'cart#decrease_count'

  post 'payment/:id/accept', to: 'payment#accept', as: :accept_payment
  post 'payment/:id/reject', to: 'payment#reject', as: :reject_payment
  get 'order_status/:id', to: 'orders#status'

  # Defines the root path route ("/")
  root "client#index"

  resources :orders, only: [:create, :show]
  resources :payment, only: [:show]
end
