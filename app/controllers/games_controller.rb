class GamesController < ApplicationController
  before_action :set_game, only: [:show, :attempted_answer, :destroy]

  def index
    @games = current_user.games
    @games.each do |game|
      if game.is_won 
        game.button_label = "Watch"
      elsif game.is_won.nil? 
        game.button_label = "Continue playing"
      else
        game.button_label = "Watch"
      end
    end
  end
  
  def new
    @game = Game.new
  end

  def create
    secret = rand(1000..9999).to_s
    if game_params[:allowed_attempts_for_the_game]
      @game = Game.build(user: current_user, secret_answer: secret, allowed_attempts_for_the_game: game_params[:allowed_attempts_for_the_game])
      @game.save
    end
    redirect_to @game
  end

  def show 
  end

  def destroy
    @game.destroy!

    respond_to do |format|
      format.html { redirect_to games_url, notice: "Game was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def attempted_answer
    puts params.inspect
    user_guessed = game_params[:attempted_answer]
    @game.attempt(user_guessed)
    if @game.is_won
      flash[:notice] = 'You won this game!!'
    end
    redirect_to @game
  end

  private

  def game_params
    params.require(:game).permit(:attempted_answer, :allowed_attempts_for_the_game)
  end

  def set_game
    @game = Game.find(params[:id])
  end
end
