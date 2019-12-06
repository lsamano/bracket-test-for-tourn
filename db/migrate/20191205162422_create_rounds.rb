class CreateRounds < ActiveRecord::Migration[5.2]
  def change
    create_table :rounds do |t|
      t.integer :bracket_id
      t.integer :round_number

      t.timestamps
    end
  end
end
