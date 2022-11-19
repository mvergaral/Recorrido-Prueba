class TurnAvailability < ApplicationRecord
  belongs_to :engineer
  belongs_to :company
  belongs_to :turn
end
