class PersonalizationSurvey < ActiveRecord::Base
  belongs_to :user

  validates :user, :presence => true
  validates :referral, :presence => true

  attr_accessible :user_id, :referral, :goal, :understand_today, :obstacles,
                  :learn, :energy, :self_body_test, :water_consumed, :fatigue,
                  :vegetables_consumed, :exercise_per_week, :feel_hunger, :eat_junkfood
end
