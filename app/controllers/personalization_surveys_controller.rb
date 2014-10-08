class PersonalizationSurveysController < ApplicationController

  def show
    @personalization_survey = PersonalizationSurvey.new
  end
end
