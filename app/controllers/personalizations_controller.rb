#https://github.com/plataformatec/devise/wiki/How-To:-Email-only-sign-up

class PersonalizationsController < ApplicationController
  def new
    @user = current_user
    @personalization_survey = PersonalizationSurvey.new
    @gender_hash = ['m', 'f']
    @referral_hash = {
      'A friend'                             => 1,
      'Social Media (Facebook, Twitter, G+)' => 2,
      'Google'                               => 3,
      'News or Blog'                         => 4
    }
  end

  def save_user
    current_user.first_name = params[:user][:first_name]
    current_user.gender = params[:user][:gender]
    p = PersonalizationSurvey.new
    p.referral = params[:personalization_survey][:referral]
    p.user = current_user
    p.save!
    current_user.save!

    redirect_to edit_personalization_surveys_path
  end
end
