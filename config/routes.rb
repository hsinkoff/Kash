Rails.application.routes.draw do
  root 'kash#index'
  get 'complete/:id', as: :complete, to: 'kash#complete'
  get 'callback/:id', as: :callback, to: 'kash#callback'
  get 'cancel/:id', as: :cancel, to: 'kash#cancel'
end
