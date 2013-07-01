Hybridise::Application.routes.draw do
  root to: "static#index"
  resources :subjects

  mount Konacha::Engine => '/konacha' if Rails.env.development?
end
