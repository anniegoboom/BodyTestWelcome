BodyTestWelcome::Application.routes.draw do
  resource :landing_flows, only: :show
  resource :personalizations, only: :show
  resource :paywalls, only: :show

  root :to => 'landing_flows#show'
end
