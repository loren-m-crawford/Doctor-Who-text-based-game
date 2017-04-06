require_relative 'data'
require_relative 'room'
require_relative 'player'

class Game
  MOVES = [
    'forward', 'backward', 'right', 'left', 'up', 'down'
  ]

  attr_accessor :standardized_move

  def initialize
    @player = Player.new(self)
  end

  def get_player_move
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
  end

  def check_room_number
    @player.room_number != 12
  end
end
