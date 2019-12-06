class Round < ApplicationRecord

  # Don't need to pass in bracket_id, but I kept it for ease of understanding
  def create_next_round(bracket_id)
    # Of a given array of game_sets, create next round (next_round)
    # with the entrants provided

    next_round = Round.create(
      bracket_id: bracket_id,
      round_number: self.round_number - 1
    )

    prev_rnd_games = self.game_sets

    if next_round.round_number == 1
      ## make limited-amount-to-all game_sets
      entrants = self.bracket.tournament.teams
      amount_of_games_to_make = entrants / 2 - prev_rnd_games.length

    else
      ## fill all next round game_sets with children
      next_rnd_games = prev_rnd_games.each_with_object([]) do |game_set, next_rnd_games|
        left_node = GameSet.create(parent_id: game_set.id, round_id: next_round.id)
        right_node = GameSet.create(parent_id: game_set.id, round_id: next_round.id)
        next_rnd_games << left_node
        next_rnd_games << right_node
      ## recursive call
      return next_round.create_next_round(bracket_id)
    end

    end

    ### BASE CASE
    if next_rnd_games.length * 2 > entrants.length
      ## If the next round would include more nodes than needed,
      # Make only one more round on some nodes

      remaining_num_of_nodes_needed = new_array.length * 2 - entrants.length
      remaining_num_of_matches_to_create = remaining_num_of_nodes_needed / 2

      shuffled_entrants = entrants.shuffle

      ## Place pointer at beginning and end indices


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

end
