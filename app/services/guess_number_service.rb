class GuessNumberService < ApplicationService
  def initialize(user_guess, game)
    @user_guess = user_guess
    @game = game
  end

  def call
    ## Check total numbers present irrespective of position
    matches = check_how_many_number_are_present

    ## Check right number with right position
    correct_positions = check_right_number_with_position

    ##
    # Subtract correct positioned number from total matches
    # Because we are showing correct positioned number and total matched number in different count
    ##
    matches = matches.length - correct_positions

    # Print the number of matches and correct positions
    [correct_positions, matches]
  end

  
  ##
  # This method will check how many numbers are present irrespective of position
  ##
  def check_how_many_number_are_present
    @user_guess.scan(/[#{@game.secret_answer}]/)
  end

  ##
  # This method will check how many numbers are present with the right position
  ##
  def check_right_number_with_position
    # Determine how many of the matches are in the correct position
    correct_positions = 0
    (0..3).each do |i|
      if @game.secret_answer.to_s[i] == @user_guess[i]
        correct_positions += 1
      end
    end
    correct_positions
  end
end
