Rails.application.routes.draw do
  devise_for :users
  root "articles#index"

  resources :articles

  match '*path', to: ->(env) { [404, {}, ['Not Found']] }, via: :all
end
