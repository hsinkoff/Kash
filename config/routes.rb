Rails.application.routes.draw do
  root 'kash#index'
  get 'complete/:id', to: 'kash#complete'
  get 'callback/:id', to: 'kash#callback'
  get 'cancel/:id', to: 'kash#cancel'
end
