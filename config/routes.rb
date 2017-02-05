Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get 'get_currencies', to: 'currencies#get_currencies', as: 'get_currencies'

  root 'currencies#index'
end
