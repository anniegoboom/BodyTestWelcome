class PersonalizationSurveysController < ApplicationController

  def show
    @personalization_survey = current_user.personalization_survey
  end

  def create
  end
end
