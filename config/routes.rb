# frozen_string_literal: true

Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :cocktails

  get 'cocktails/:id/doses/new', to: 'doses#new', as: :new_dose
  post 'cocktails/:id/doses', to: 'doses#create'
  get 'cocktails/:id/doses', to: 'doses#index', as: :doses
  delete 'doses/:id', to: 'doses#destroy', as: :delete_dose
  patch 'cocktails/:id', to: 'cocktails#update', as: :update_cocktail
end
