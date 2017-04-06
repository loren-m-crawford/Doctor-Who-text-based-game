require_relative 'data'
require_relative 'room'
require_relative 'player'
require 'pry'

class Game
  MOVES = [
    'forward', 'backward', 'right', 'left', 'up', 'down'
  ]
  POSTIVE_FEEDBACK = [
    'Correct!',"You must be a mad man with a box, because that's correct!",
    "Did you just pretend that was a plan? Well it worked!",
    "Aren't you a right good Whovian!?",
    "Well done! That wasn't wibbly wobbly at all! :)"]

  attr_accessor :standardized_move, :player

  def initialize
    @player = Player.new
  end

  def game_intro
    puts File.read('game_intro.txt')
    play
  end

  def get_player_move
    move = $stdin.gets.downcase.strip
    exit if move == 'exit'
    check_move(move)
  end

  def check_move(move)
    MOVES.each do |m|
      @standardized_move = m if m =~ Regexp.new(move)
    end
    give_move_feedback if @standardized_move.nil?
  end

  def player_room
     Room.new(@player)
  end

  #TODO break this apart
  def play
    get_player_move
    @player.move(@standardized_move)

    puts "You're in #{player_room.room_number}."
    puts "#{player_room.question}"
    get_player_answer
    if check_answer == false
      puts "That's not right. Try again."
    else
      puts POSITIVE_FEEDBACK.sample
      puts "#{player_room.hint}"
    end
    puts File.read('winning_text.txt') if player_room.winning_room?
    return
  end

  def give_move_feedback
      puts "That's not a valid move. Please type in 'b for backward', 'f for forward', 'r for right', 'l for left', 'u for up', and 'd for down.'"
      get_player_move
  end

  def get_player_answer
    @answer = $stdin.gets.downcase.strip
  end

  def check_answer
    player_room.answer == @answer
  end

  private
  def run_game
    game_intro
    get_player_move
  end
end

# game = Game.new
# game.send(:run_game)
