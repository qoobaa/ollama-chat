Rails.application.routes.draw do
  get "up" => "rails/health#show", as: :rails_health_check
  resources :chats do
    resources :messages
  end
  root "chats#index"
end
