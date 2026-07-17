class Bus < ApplicationRecord
  belongs_to :route   
  
  has_many :bookings, dependent: :destroy    # automatically destroy associated child records when parent record is deleted

  before_validation :downcase_bus_type

  before_validation :upcase_departure_time

  before_create :initialize_available_seats

  before_create :generate_bus_id

  before_create :initialize_available_seats

  before_save :titleize_bus_name

  before_save :upcase_bus_number

  VALID_BUS_TYPE = ["non_ac", "ac", "sleeper"]

  VALID_REGISTRATION_NUMBER = /\A[A-Z]{2}\d{2}[A-Z]{2}\d{4}\z/

  VALID_DEPARTURE_TIME = /\A(0[1-9]|1[0-2])[:.][0-5]\d[AP]M\z/

  validates :departure_time, presence: true, format: {
    with: VALID_DEPARTURE_TIME
  }

  validates :bus_number, presence: true

  validates :bus_name, presence: true

  validates :total_seats,presence: true, numericality: {
    greater_than: 0
  }

  validates :bus_type, presence: true, inclusion: {
    in: VALID_BUS_TYPE
  }

  validates :available_seats, presence: true, numericality: {
    greater_than_or_equal_to: 0,
  }

  validates :registration_number, presence: true, uniqueness: true, format: {
    with: VALID_REGISTRATION_NUMBER,
    message: "Must Be Like XX99XX9999"
  }

  private

  def initialize_available_seats
    self.available_seats = total_seats
  end

  def downcase_bus_type
    self.bus_type = bus_type.strip.downcase if bus_type.present?          # self.bus_type => bus_type attribute of current route object
  end

  def titleize_bus_name
    self.bus_name = bus_name.titleize if bus_name.present?
  end

  def upcase_bus_number
    self.bus_number = bus_number.upcase if bus_number.present?
  end

  def upcase_departure_time
    self.departure_time = departure_time.upcase.delete(" ") if departure_time.present?
  end
end