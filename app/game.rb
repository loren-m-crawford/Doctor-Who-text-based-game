require_relative 'data'
require_relative 'room'
require_relative 'player'
require 'pry'

class Game
  MOVES = [
    'forward', 'backward', 'right', 'left', 'up', 'down'
  ]

  attr_accessor :standardized_move

  def initialize
    @player = Player.new(self)
    run_game
  end

  def game_intro
    puts File.read('game_intro.txt')
  end

  def get_player_move
    binding.pry
    move = $stdin.gets.downcase.strip
    check_move(move)
  end

  def check_move(move)
    MOVES.each do |m|
      @standardized_move = m if m =~ Regexp.new(move)
    end
    give_move_feedback if @standardized_move.nil?
  end

  def give_move_feedback
      puts "That's not a valid move. Please type in 'b for backward', 'f for forward', 'r for right', 'l for left', 'u for up', and 'd for down.'"
      get_player_move
  end

  def get_player_answer
    answer = $stdin.gets.downcase.strip
  end

  private
  def run_game
    game_intro
    get_player_move
  end
end

Game.new
