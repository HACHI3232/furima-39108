Rails.application.routes.draw do
  devise_for :users
  get 'items/index'
  get 'messages/index'
  root to: "items#index"

end
