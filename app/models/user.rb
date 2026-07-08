class User < ApplicationRecord
  has_many :bookings

  has_secure_password


  enum :role, {
    user: 0, 
    admin: 1
  }, default: :user

  VALID_EMAIL = /\A[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}\z/

  VALID_PASSWORD = /\A(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@#$%^&+=!]).{8,}\z/

  # GENDER_OPTIONS = %w[Male Female Other]
  enum :gender, {
    male: 0,
    female: 1,
    other: 2
  }

  # validates :gender, inclusion: {
  #   in: %w[male female other]
  # }

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

  validates :age, presence: true, numericality: true

  # validates :gender, presence: true, inclusion: {
  #   in: GENDER_OPTIONS,
  #   message: "%{value} is not valid gender option!!!"
  # }

  validate :name_should_not_be_an_email

  private

  def name_should_not_be_an_email
    errors.add(:name, "Should Not Be Email!!!") if name == email
  end
end
