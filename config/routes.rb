Rails.application.routes.draw do
  # devise_for :users
  devise_for :users, :path_names => {
    :verify_authy => "/verify-token",
    :enable_authy => "/enable-two-factor"
  }  
  root "articles#index"

  resources :articles

  match '*path', to: ->(env) { [404, {}, ['Not Found']] }, via: :all

end
