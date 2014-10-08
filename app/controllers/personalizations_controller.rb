#https://github.com/plataformatec/devise/wiki/How-To:-Email-only-sign-up

class PersonalizationsController < ApplicationController
  def show
    @user = current_user
    @personalization_survey = PersonalizationSurvey.new
  end

  def save_user
    redirect_to personalization_survey_show_path
  end
end
