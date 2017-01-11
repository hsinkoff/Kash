Rails.application.routes.draw do
  root 'kash#index'
  get 'complete', as: :complete, to: 'kash#complete'
  post 'callback', as: :callback, to: 'kash#callback'
  get 'cancel', as: :cancel, to: 'kash#cancel'
end
