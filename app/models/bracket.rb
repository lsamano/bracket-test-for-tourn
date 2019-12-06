class Bracket < ApplicationRecord

  def add_root_game_set(round)
    # Makes root_game_set and round

    game_set = GameSet.create(round_id: round.id)
    self.update(game_set_id: game_set.id)
    return game_set
  end

  # def make_next_round(game_sets_array, entrants)
  #   # per game_set, add two games
  # end
  #
  # def add_child_game_sets()
  # end

  def create_next_round(array, entrants)
    # Of a given round (array), create next round (new_array)
    # with the entrants provided
    new_array = array.each_with_object([]) do |given_node, new_array|
      left_node = Node.create(parent_id: given_node.id)
      right_node = Node.create(parent_id: given_node.id)
      new_array << left_node
      new_array << right_node
    end

    ### BASE CASE
    if new_array.length * 2 > entrants.length
      ## If the next round would include more nodes than needed,
      # Make only one more round on some nodes

      remaining_num_of_nodes_needed = new_array.length * 2 - entrants.length
      remaining_num_of_matches_to_create = remaining_num_of_nodes_needed / 2

      shuffled_entrants = entrants.shuffle

      ## Place pointer at beginning and end indices


      # if remaining_num_of_matches_to_create <= new_array.length / 2
      #   new_array.each_with_index do |node, index|
      #     if index % 2 == 0 # if even number
      #       entrant = shuffled_entrants.shift()
      #       node.update(name: entrant["name"])
      #       node.update(team_id: entrant["id"])
      #     end
      #     break if shuffled_entrants.length == 0
      #   end
      # else
      #   # need logic for handling more than half the extra matches
      #   # some matches/groups will be complete
      # end

    elsif new_array.length == entrants.length
      ## If the current round has exactly enough nodes,
      # .each over them to fill them with the shuffled entrants
      shuffled_entrants = entrants.shuffle
      new_array.each do |node|
        node.update(name: shuffled_entrants[0]["name"])
        node.update(team_id: shuffled_entrants.shift()["id"])
      end
    else
      # Recursively create next round of Nodes
      create_next_round(new_array, entrants)
    end
  end

  def make_bracket(entrants)

    # This determines number of rounds
    rounds = Math.log2(entrants.length).ceil

    finals_round = Round.create(bracket_id: self.id, round_number: rounds)
    GameSet.create(parent_id: nil, round_id: finals_round.id)
    
    # see above for definition
    array_of_first_games = finals_round.create_next_round(self.id)
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
