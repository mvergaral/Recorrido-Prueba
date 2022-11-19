class Turn < ApplicationRecord
  belongs_to :engineer, optional: true
  belongs_to :company
  has_many :turn_availabilities,  dependent: :destroy
end
