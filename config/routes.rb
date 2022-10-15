Rails.application.routes.draw do
  devise_for :users

  mount ActionCable.server => '/cable'

  post 'cart/checkout', to: 'cart#checkout'
  post 'cart/show', to: 'cart#show'
  post 'cart/add', to: 'cart#add'
  post 'cart/remove', to: 'cart#remove'
  post 'cart/increase_count', to: 'cart#increase_count'
  post 'cart/decrease_count', to: 'cart#decrease_count'

  post 'orders/board', to: 'orders#render_board'

  post 'payment/:id/accept', to: 'payment#accept', as: :accept_payment
  post 'payment/:id/reject', to: 'payment#reject', as: :reject_payment
  get 'order_status/:id', to: 'orders#status'
  get 'board_order/:id', to: 'orders#board_order'

  root "client#index"

  resources :orders, only: [:index, :create, :show, :update]
  resources :payment, only: [:show]
end
