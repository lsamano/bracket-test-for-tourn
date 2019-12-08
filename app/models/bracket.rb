class Bracket < ApplicationRecord
  # has_one :game_set
  has_many :rounds

  def add_root_game_set(round)
    # Makes root_game_set and round

    game_set = GameSet.create(round_id: round.id)
    self.update(game_set_id: game_set.id)
    return game_set
  end

  def make_bracket(entrants)

    # This determines number of rounds
    rounds = Math.log2(entrants.length).ceil

    finals_round = Round.create(bracket_id: self.id, round_number: rounds)
    GameSet.create(parent_id: nil, round_id: finals_round.id)

    # see above for definition
    array_of_first_games = finals_round.create_next_round(self.id, entrants)

    shuffled_entrants = entrants.shuffle
    array_of_first_games.each do |game_set|
      game_set.update(
        team_1_id: shuffled_entrants.shift()["id"],
        team_2_id: shuffled_entrants.shift()["id"]
      )
    end
    puts "worked"
    ### WIP iterate over array_of_first_games to fill them with entrants
  end
end


# # Make rounds associated with bracket
# rounds.times do |round_index|
#   round_number = rounds - round_index
#   round = Round.create(bracket_id: self.id, round_number: round_number)
#   if round_index == 0 ## if first round
#     starting_array = add_root_game_set(round)
# places it in an array and returns array
# game_sets_in_round_in_array = [game_set]
#     # make_next_round(starting_array, entrants)
#   else ##
#
#   end
# end

# per round of the bracket
# self.rounds.each do |round|
#
# end

##############################################################

##############################################################
