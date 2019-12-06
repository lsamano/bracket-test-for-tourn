class CreateGameSets < ActiveRecord::Migration[5.2]
  def change
    create_table :game_sets do |t|
      t.integer :parent_id
      t.integer :team_1_id
      t.integer :team_2_id
      t.string :round_id

      t.timestamps
    end
  end
end
