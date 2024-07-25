class CreateGames < ActiveRecord::Migration[7.1]
  def change
    create_table :games do |t|
      t.references :user, null: false, foreign_key: true
      t.integer :secret_answer
      t.string :user_attempts, default: ''
      t.string :game_responses, default: ''
      t.boolean :is_won
      t.integer :attempts_count, default: 0
      t.integer :allowed_attempts_for_the_game

      t.timestamps
    end
  end
end

