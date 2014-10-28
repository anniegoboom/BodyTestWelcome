class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  validates_presence_of :email

  has_one :personalization_survey

  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable

  attr_accessible :first_name, :last_name, :email, :password, :password_confirmation,
                  :date_of_birth, :gender

  def password_required?
    super if confirmed?
  end

  def password_match?
    self.errors[:password] << "can't be blank" if password.blank?
    self.errors[:password_confirmation] << "can't be blank" if password_confirmation.blank?
    self.errors[:password_confirmation] << "does not match password" if password != password_confirmation
    password == password_confirmation && !password.blank?
  end

  def age
    calculate_age
  end

  private

  def calculate_age(from_date: Time.now.utc.to_date)
    return nil if date_of_birth.nil? || date_of_birth > from_date

    from_date.year - date_of_birth.year - ((from_date.month > date_of_birth.month || (from_date.month == date_of_birth.month && from_date.day >= date_of_birth.day)) ? 0 : 1)
  end
end
