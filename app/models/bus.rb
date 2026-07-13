class Bus < ApplicationRecord
  belongs_to :route   
  
  has_many :bookings, dependent: :destroy    # automatically destroy associated child records when parent record is deleted

  before_validation :downcase_bus_type

  before_create :initialize_available_seats

  before_create :generate_bus_id

  before_create :initialize_available_seats

  # enum :bus_type,{
  #   non_ac: 0,
  #   ac: 1,
  #   sleeper: 2
  # }, default: :non_ac

  BUS_TYPE = %W[non_ac ac sleeper]

  validates :bus_number, presence: true

  validates :bus_name, presence: true

  validates :total_seats,presence: true, numericality: {
    greater_than: 0
  }

  validates :bus_type, presence: true, inclusion: {
    in: BUS_TYPE
  }

  # validates :available_seats, presence: true, numericality: {
  #   greater_than_or_equal_to: 0
  # }

  VALID_REGISTRATION_NUMBER = /\A[A-Z]{2}\d{2}[A-Z]{2}\d{4}\z/

  validates :registration_number, presence: true, uniqueness: true, format: {
    with: VALID_REGISTRATION_NUMBER,
    message: "Must Be Like XX99XX9999"
  }

  private

  def initialize_available_seats
    self.available_seats = total_seats
  end

  def generate_bus_id
    last_bus = Bus.order(:id).last

    next_number = 
    if last_bus&.bus_id.present?
      last_bus.bus_id.delete("BUS").to_i + 1
    else
      1
    end
    self.bus_id = "BUS#{next_number.to_s.rjust(6, "0")}"
  end

  def downcase_bus_type
    self.bus_type = bus_type.strip.downcase if bus_type.present?          # self.bus_type => bus_type attribute of current route object
  end
end