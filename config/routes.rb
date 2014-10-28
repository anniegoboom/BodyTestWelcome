BodyTestWelcome::Application.routes.draw do
  devise_for :users, :controllers => {:confirmations => 'users/confirmations', registrations: 'users/registrations', passwords: 'users/passwords'}

  devise_scope :user do
    match "/confirm", to: "confirmations#confirm"
  end

  resource :landing_flows, only: :show

  resource :personalizations, only: :new
  match "/save_user", to: "personalizations#save_user", via: :put

  resource :personalization_surveys, only: [:edit, :update]
  resource :paywalls, only: :show

  root :to => 'landing_flows#show'
end
