require_relative 'data'
require_relative 'world'
require_relative 'room'
require_relative 'player'
#require_relative 'game_intro.txt'

class Game
  MOVES = [
    'forward', 'backward', 'right', 'left', 'up', 'down'
  ]
  def initialize
    @world = World.new
    @player = Player.new
  end

  def get_player_move
    move = gets.downcase.strip
    check_move(move)
  end

  def check_move(move)
    MOVES.each do |m|
      move = m if m =~ Regexp.new(move)
      break
    end
    give_move_feedback
  end

  def give_move_feedback
      puts "That's not a valid move. Please type in 'b for backward', 'f for forward', 'r for right', 'l for left', 'u for up', and 'd for down.'"
  end

  def room_number
    ROOMS[[@player.z_coord,@player.x_coord,@player.y_coord]]['room number']
  end

  def check_room_number
     room_number != 12
  end
end

