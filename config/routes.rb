Rails.application.routes.draw do
  root 'kash#index'
  get 'complete', to: 'kash#complete'
  post 'callback', to: 'kash#callback'
  get 'cancel', to: 'kash#cancel'
end
