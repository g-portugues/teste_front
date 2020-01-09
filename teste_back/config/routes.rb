Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  api_version(
    module: 'V1',
    :header => {
      :name => 'Accept',
      :value => 'application/vnd.testbackend.com.br; version=1'
    }
  ) do    
    post '/auth/login', to: 'authentication#login'
    resources :users
    resources :books
    resources :authors
    resources :publishers
  end
end
