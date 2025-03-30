# frozen_string_literal: true

Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :events, only: %i[index create update destroy] do 
      end
      post "tickets/:ticket_id/bookings", to: "bookings#create"
    end
  end
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }
end
