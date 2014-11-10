# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
BodyTestWelcome::Application.initialize!

# Mailer for devise
ActionMailer::Base.delivery_method = :smtp
ActionMailer::Base.raise_delivery_errors = false
ActionMailer::Base.default :charset => "utf-8"

ActionMailer::Base.perform_deliveries = true
ActionMailer::Base.default_url_options = { :host => 'http://body-test-welcome.herokuapp.com' }

ActionMailer::Base.smtp_settings = {
  address: "smtp.gmail.com",
  port: 587,
  domain: ENV["GMAIL_DOMAIN"],
  authentication: :plain,
  enable_starttls_auto: true,
  user_name: ENV["GMAIL_USERNAME"],
  password: ENV["GMAIL_PASSWORD"]
}
