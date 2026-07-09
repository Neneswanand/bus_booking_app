class Bus < ApplicationRecord
  belongs_to :route       # Database normalization( It avoids duplications)
end
