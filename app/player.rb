require_relative 'data'
#require_relative 'game_intro.txt'

class Player
attr_accessor :z_coord, :x_coord, :y_coord, :game

  def initialize(game)
    @z_coord, @x_coord, @y_coord = 1, 0, 1
    @room = Room.new(self)
    @game = game
  end

  def where_am_i
    floor = z_coord
    room_number = @room.room_number
    return "You're on floor #{floor}, by room #{room_number}."
  end

  def coordinates 
    [@z_coord, @x_coord, @y_coord]
  end

  def move
    case game.standardized_move
    when 'forward'
      @y_coord += 1 if @y_coord < 2
    when 'backward'
      @y_coord -= 1 if @y_coord > 0
    when 'up'
      @z_coord += 1 if @z_coord < 2
    when 'down'
      @z_coord -= 1 if @z_coord > 0
    when 'right'
      @x_coord += 1 if @x_coord < 2
    when 'left'
      @x_coord -= 1 if @x_coord > 0
    end
  end
end
