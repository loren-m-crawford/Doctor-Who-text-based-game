require_relative 'data'
require_relative 'room'
require_relative 'player'
require 'pry'

class Game
  MOVES = [
    'forward', 'backward', 'right', 'left', 'up', 'down'
  ]

  POSITIVE_FEEDBACK = [
    'Correct!',"You must be a mad man with a box, because that's correct!",
    "Did you just pretend that was a plan? Well it worked!",
    "Aren't you a right good Whovian!?",
    "Well done! That wasn't wibbly wobbly at all! :)"]

  attr_reader :standardized_move, :player

  def initialize
    @player = Player.new
  end

  def game_intro
    puts File.read('game_intro.txt')
    play
  end

  def get_player_move
    print 'which way would you like to go?'
    move = $stdin.gets.downcase.strip
    exit if move == 'exit'
    check_move(move)
  end

  def check_move(move)
    standardized_move = MOVES.select { |m| m =~ Regexp.new(move) }.first
    standardized_move.nil? ? give_move_feedback : standardized_move
  end

  def player_room
     Room.new(@player)
  end

  def print_question
    print "You're in #{player_room.room_number}. Here's your question: #{player_room.question}"
  end

  def play
    while !player_room.winning_room?
      move = get_player_move
      @player.move(move)
      player_wins? ? break : print_question
      get_player_answer
    end
  end

  def player_wins?
    if player_room.winning_room?
      puts File.read('winning_text.txt') 
      return true
    end
  end

  def give_move_feedback
      puts "That's not a valid move. Please type in 'b for backward', 'f for forward', 'r for right', 'l for left', 'u for up', and 'd for down.'"
      get_player_move
  end

  def get_player_answer
    player_answer = $stdin.gets.downcase.strip
    check_answer(player_answer)
  end

  def check_answer(player_answer)
    if player_room.answer != player_answer
      puts "That's not right. Try again."
    else
      puts POSITIVE_FEEDBACK.sample
      puts "#{player_room.hint}"
    end
  end

  private
  def run_game
    game_intro
  end
end

# game = Game.new
# game.send(:run_game)
