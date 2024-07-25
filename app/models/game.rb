class Game < ApplicationRecord
  belongs_to :user  
  attr_accessor :button_label

  def attempt(user_guess)
    self.attempts_count += 1
    correct_positions, matches = GuessNumberService.call(user_guess, self)
    self.is_won = true if secret_answer == user_guess.to_i
    self.game_responses += " #{correct_positions} #{matches}," 
    self.user_attempts += " #{user_guess},"
    if self.attempts_count >= allowed_attempts_for_the_game
      self.is_won = false
      puts "Sorry, you have run out of guesses. The secret number was #{secret_answer}. You lost the game."
    end
    self.save
  end
end
