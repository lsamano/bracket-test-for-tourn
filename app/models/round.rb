class Round < ApplicationRecord
  belongs_to :bracket
  has_many :game_sets

    # Don't need to pass in bracket_id, but I kept it for ease of understanding
    def create_next_round(bracket_id, entrants_array)
      # Of a given array of game_sets, create next round (next_round)
      # with the entrants provided

      next_round = Round.create(
        bracket_id: bracket_id,
        round_number: self.round_number - 1
      )

      prev_rnd_games = self.game_sets
      copy_games = prev_rnd_games.clone

      # Must determine if round is final or not
      if next_round.round_number == 1 # next_round is last round, Base Case
        ## make limited-amount-to-all game_sets
        amount_of_prev_games = prev_rnd_games.length
        # entrants_array = self.bracket.tournament.teams
        amount_of_games_to_make = (entrants_array.length/2.to_f).ceil - amount_of_prev_games

        # Check if below halfway to prev_rnd_games amount
        if (amount_of_prev_games/2.to_f).ceil > amount_of_games_to_make
          incrementer = (amount_of_prev_games/amount_of_games_to_make.to_f).ceil
          index = 0
          while amount_of_games_to_make > 0
            # add children
            one_game_set = prev_rnd_games[index]
            # puts entrants_array.length
            if amount_of_games_to_make == 1 && entrants_array.length.odd?
            left_node = GameSet.create(parent_id: one_game_set.id, round_id: next_round.id)
            # byebug
            ent_array = entrants_array.to_a.shuffle
            one_game_set.update(team_2_id: ent_array.shift()["id"])

            copy_games = copy_games.map { |game_set| game_set.id == one_game_set.id ? left_node : game_set }
            else
              left_node = GameSet.create(parent_id: one_game_set.id, round_id: next_round.id)
              right_node = GameSet.create(parent_id: one_game_set.id, round_id: next_round.id)
              copy_games = copy_games.flat_map { |game_set| game_set.id == one_game_set.id ? [left_node, right_node] : game_set }
            end
            amount_of_games_to_make -= 1
            index += incrementer
          end
        else # above half
          incrementer = 2
          index = 0
          while index <= amount_of_prev_games - 1
            # add children
            one_game_set = prev_rnd_games[index]
            if amount_of_games_to_make == 1 && entrants_array.length.odd?
            left_node = GameSet.create(parent_id: one_game_set.id, round_id: next_round.id)
            # byebug
            ent_array = entrants_array.to_a.shuffle
            one_game_set.update(team_2_id: ent_array.shift()["id"])

            copy_games = copy_games.map { |game_set| game_set.id == one_game_set.id ? left_node : game_set }
            else
              left_node = GameSet.create(parent_id: one_game_set.id, round_id: next_round.id)
              right_node = GameSet.create(parent_id: one_game_set.id, round_id: next_round.id)
              copy_games = copy_games.flat_map { |game_set| game_set.id == one_game_set.id ? [left_node, right_node] : game_set }
            end
            amount_of_games_to_make -= 1
            index += incrementer
          end
          # Go back and add the remaining games
          index = 1
          while amount_of_games_to_make > 0
            # add children
            one_game_set = prev_rnd_games[index]
            if amount_of_games_to_make == 1 && entrants_array.length.odd?
            left_node = GameSet.create(parent_id: one_game_set.id, round_id: next_round.id)
            # byebug
            ent_array = entrants_array.to_a.shuffle
            one_game_set.update(team_2_id: ent_array.shift()["id"])

            copy_games = copy_games.map { |game_set| game_set.id == one_game_set.id ? left_node : game_set }
            else
              left_node = GameSet.create(parent_id: one_game_set.id, round_id: next_round.id)
              right_node = GameSet.create(parent_id: one_game_set.id, round_id: next_round.id)
              copy_games = copy_games.flat_map { |game_set| game_set.id == one_game_set.id ? [left_node, right_node] : game_set }
            end

            amount_of_games_to_make -= 1
            index += incrementer
          end
        end
        puts copy_games
        # return copy_games
        shuffled_entrants = ((ent_array && ent_array.shuffle) || entrants_array.shuffle)
        copy_games.each do |game_set|
          # puts shuffled_entrants.length
          game_set.update(
            team_1_id: shuffled_entrants.shift()["id"],
            team_2_id: shuffled_entrants.shift()["id"]
          )
        end
        puts "worked"


      else
        ## fill all next_round's game_sets with children
        prev_rnd_games.each do |game_set|
          left_node = GameSet.create(parent_id: game_set.id, round_id: next_round.id)
          right_node = GameSet.create(parent_id: game_set.id, round_id: next_round.id)
        end
        ## recursive call
        return next_round.create_next_round(bracket_id, entrants_array)
      end

    end
end
