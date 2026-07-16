class User < ApplicationRecord
  has_many :bookings, dependent: :destroy

  has_secure_password

  before_save :downcase_email

  before_validation :capitalize_gender

  before_save :titleize_name

  before_create :generate_u_id

  enum :role, {
    user: 0, 
    admin: 1
  }, default: :user

  VALID_EMAIL = /\A[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}\z/

  VALID_PASSWORD = /\A(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@#$%^&+=!]).{8,}\z/

  
  GENDER_OPTIONS = %w[Male Female Other]
  # enum :gender, {
  #   male: 0,
  #   female: 1,
  #   other: 2
  # }, validate: true

  validates :name, presence: true

  validates :email, presence: true, uniqueness: true, format: {
    with: VALID_EMAIL
  }

  validates :password, presence: true, format: {
    with: VALID_PASSWORD
  }, on: :create

  # validates :role, inclusion: {
  #   in: %w[user admin]
  #   }

  validates :phone, presence: true, length: { is: 10}

  validates :age, presence: true, numericality: true, numericality: {
    greater_than: 0,
    less_than: 150
  }


  validates :gender, presence: true, inclusion: {
    in: GENDER_OPTIONS,
    message: "%{value} is not valid gender option!!!"
  }

  validate :name_should_not_be_an_email

  private

  def name_should_not_be_an_email
    errors.add(:name, "Should Not Be Email!!!") if name == email
  end

  def downcase_email
    self.email = email.downcase if email.present?         # email attribute of current User object
  end

  def capitalize_gender
    # self.gender = gender.capitalize if gender.present?
    self.gender = gender.humanize.delete(" ") if gender.present?
  end

  def titleize_name
    self.name = name.titleize if name.present?
  end

  # def generate_u_id
  #   last_user = User.order(:id).last

  #   next_number = 
  #   if last_user&.u_id.present?
  #     last_user.u_id.delete("BBA").to_i + 1
  #   else
  #     1
  #   end
  #   self.u_id = "BBA#{next_number.to_s.rjust(6, "0")}"
  # end

  def generate_u_id
    last_user = User.order(:id)

    if last_user.nil?
      self.u_id = "BBA000001"
    else
      next_number = last_user.u_id.delete("BBA").to_i + 1
      self.u_id = "BBA#{next_number.to_s.rjust(6, "0")}"
    end
  end
end
