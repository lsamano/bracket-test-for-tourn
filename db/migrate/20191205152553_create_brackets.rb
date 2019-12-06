class CreateBrackets < ActiveRecord::Migration[5.2]
  def change
    create_table :brackets do |t|
      t.integer :game_set_id

      t.timestamps
    end
  end
end
