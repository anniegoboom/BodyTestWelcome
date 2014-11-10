#https://github.com/plataformatec/devise/wiki/How-To:-Email-only-sign-up

class PersonalizationsController < ApplicationController
  def new
    @user = current_user
    @personalization_survey = PersonalizationSurvey.new
    setup_survey_answers
  end

  def save_user
    get_personalization_responses
    @user = current_user
    @user.update_attributes(@user_params)
    @personalization_survey = PersonalizationSurvey.new(@p13n_referral)
    @personalization_survey.user = current_user

    if @user.save && @personalization_survey.save
      redirect_to edit_personalization_surveys_path
    else
      setup_survey_answers
      flash[:error] = "Please fix the following errors: A referral is required"
      render :new
    end
  end

  private

  def get_personalization_responses
    user_params = params.require(:user)
    personalization_survey = params.require(:personalization_survey)

    @user_params = user_params.permit(
      :first_name,
      :gender
    )

    @p13n_referral = personalization_survey.permit(:referral)
  end

  def setup_survey_answers
    @gender_hash = {
      'Male'   => 'm',
      'Female' => 'f'
    }
    @referral_hash = {
      'A friend'                             => 1,
      'Social Media (Facebook, Twitter, G+)' => 2,
      'Google'                               => 3,
      'News or Blog'                         => 4
    }
  end
end
