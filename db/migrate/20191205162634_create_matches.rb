class CreateMatches < ActiveRecord::Migration[5.2]
  def change
    create_table :matches do |t|
      t.integer :game_set_id
      t.integer :winner_id
      t.integer :loser_id
      t.string :description

      t.timestamps
    end
  end
end
