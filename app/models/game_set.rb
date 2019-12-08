class GameSet < ApplicationRecord
  belongs_to :round
  has_many :matches
  # parent_id
  # team_1_id
  # team_2_id
end
