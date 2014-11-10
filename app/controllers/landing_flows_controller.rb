class LandingFlowsController < ApplicationController
  before_filter :redirect_if_logged_in, only: :show

  def show
  end

  def redirect_if_logged_in
    if logged_in?
      if current_user.personalization_survey.nil?
        redirect_to new_personalizations_path
      else
        redirect_to_paywall
      end
    end
  end

  def redirect_to_paywall

    redirect_to PersonalizationSurveysController::BODY_TEST_PAYMENTS_URL
  end

  def logged_in?
    !current_user.nil?
  end
end
