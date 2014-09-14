class CreatePersonalizationSurveyTable < ActiveRecord::Migration
  def change
    create_table(:personalization_survey) do |t|
      t.integer :user_id,           null: false
      t.integer :referral,          null: false
      t.integer :goal
      t.integer :understand_today
      t.integer :obstacles
      t.integer :learn
      t.integer :energy
      t.boolean :self_body_test
      t.integer :water_consumed
      t.integer :fatigue
      t.integer :vegetables_consumed
      t.integer :exercuse_per_week
      t.integer :feel_hunger
      t.integer :eat_junkfood


      t.timestamps
    end
  end
end
