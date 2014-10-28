class PersonalizationSurveysController < ApplicationController

  def edit
    @personalization_survey = current_user.personalization_survey
    setup_survey_options
  end

  def update
    # current_user.

    # if @company.save
    #   redirect_to root_url
    # else
    #   render :new
    # end
  end

  private

  def setup_survey_options
    @goal_answers_hash = {
      'Lose weight'                        => 1,
      'Gain weight'                        => 2,
      'Feel healthier'                     => 3,
      'Feel more confident'                => 4,
      'Look more attractive'               => 5,
      'Look more attractive'               => 6,
      "Learn about my body's unique needs" => 7,
      'Live a healthier lifestyle'         => 8
    }

    @understand_today_answer_hash = {
      '1' => 'yes',
      '2' => 'no',
      '3' => ''
    }

    @obstacles_answer_hash = {
    }
  end
end
