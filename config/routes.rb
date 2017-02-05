Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get 'get_currencies', to: 'currencies#get_currencies', as: 'get_currencies'
  post 'convert_currency' => 'currencies#convert_currency', as: 'convert_currency'

  root 'currencies#index'
end
