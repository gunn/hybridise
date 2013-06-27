Hybridise::Application.routes.draw do
  resources :subjects

  root to: "static#index"

end
