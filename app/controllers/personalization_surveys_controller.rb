class PersonalizationSurveysController < ApplicationController
  BODY_TEST_PAYMENTS_URL = "http://www.thebodytest.com/pricing/"

  def edit
    @personalization_survey = current_user.personalization_survey
    setup_survey_answers
  end

  def update
    @personalization_survey = current_user.personalization_survey

    if @personalization_survey.update_attributes(survey_params)
      redirect_to BODY_TEST_PAYMENTS_URL
    else
      setup_survey_answers

      errors_array = []
      if @personalization_survey.errors.any?
        @personalization_survey.errors.full_messages.each do |msg|
          errors_array << msg
        end
      end

      flash[:error] = "Please fix the following errors: \n"+errors_array.join("\n")

      render :edit
    end
  end

  private

  def survey_params
    survey_answers = params.require(:personalization_survey)
    survey_answers.permit(
      :goal,
      :understand_today,
      :obstacles,
      :learn,
      :energy,
      :self_body_test,
      :water_consumed,
      :fatigue,
      :vegetables_consumed,
      :exercise_per_week,
      :feel_hunger,
      :eat_junkfood
    )
  end

  def setup_survey_answers
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
      'Beginner: I don’t really know what I need to do to feel healthy' => 1,
      'Intermediate: I know a few behaviors that help me feel healthy'  => 2,
      'Advanced: I know a lot about how to feel healthy'                => 3
    }

    @obstacles_answer_hash = {
      "I’m too busy to cook"                  => 1,
      'I eat too much'                        => 2,
      'I drink too much'                      => 3,
      "I’m don’t exercise enough"             => 4,
      'I don’t sleep enough'                  => 5,
      'I’m too stressed'                      => 6,
      "I don’t know what to do"               => 7,
      'I need someone to hold me accountable' => 8
    }

    @learn_answer_hash = {
      'How much I should sleep'           => 1,
      'How much water I should drink'     => 2,
      'Which foods help me feel healthy'  => 3,
      'How to exercise'                   => 4,
      'How to form healthy habits'        => 5
    }

    @energy_answer_hash = {
      'I feel tired most of the day'      => 1,
      'I feel energetic part of the day'  => 2,
      'I feel energetic most of the day'  => 3
    }

    @self_body_test_hash = {
      'yes' => 1,
      'no'  => 2
    }

    @water_answer_hash = {
      '0-7 cups' => 1,
      '8 cups'   => 2
    }

    @fatigue_answer_hash = {
      'Very tired'                => 1,
      'A little tired'            => 2,
      'Energetic and well rested' => 3
    }

    @vegetables_answer_hash = {
      '0 Servings'   => 1,
      '1-4 Servings' => 2,
      '5+ Servings'  => 3
    }

    @exercise_answer_hash = {
      '0'      => 1,
      '1-2'    => 2,
      '3-4'    => 3,
      '5+'     => 4,
    }

    @hunger_answer_hash = {
      'Never'                           => 1,
      'Rarely (a few times a month)'    => 2,
      'Sometimes (a few times a week)'  => 3,
      'Often (several times a day)'     => 4,
      'Constantly (all day long)'       => 5
    }

    @junkfood_answer_hash = {
      'Never'                           => 1,
      'Rarely (a few times a month)'    => 2,
      'Sometimes (a few times a week)'  => 3,
      'Often (several times a day)'     => 4,
      'Constantly (all day long)'       => 5
    }
  end
end
