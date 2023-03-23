Rails.application.routes.draw do
  get 'items/index'
  get 'messages/index'
  root to: "items#index"

end
