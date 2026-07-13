class Booking < ApplicationRecord
  belongs_to :user          # one-to-one connection

  belongs_to :bus

  
end
