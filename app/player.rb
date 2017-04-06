require_relative 'data'
#require_relative 'game_intro.txt'

class Player
  attr_accessor :z_coord, :x_coord, :y_coord, :room

  MAX_MOVE = 2
  MIN_MOVE = 0

  def initialize
    @z_coord, @x_coord, @y_coord = 1, 0, 1
    @room = Room.new(self)
  end

  def where_am_i
    floor = z_coord
    room_number = @room.room_number
    return "You're on floor #{floor}, by room #{room_number}."
  end

  def coordinates 
    [@z_coord, @x_coord, @y_coord]
  end

  def move(move)
    case move
    when 'forward'
      @y_coord += 1 if @y_coord < MAX_MOVE
    when 'backward'
      @y_coord -= 1 if @y_coord > MIN_MOVE
    when 'up'
      @z_coord += 1 if @z_coord < MAX_MOVE
    when 'down'
      @z_coord -= 1 if @z_coord > MIN_MOVE
    when 'right'
      @x_coord += 1 if @x_coord < MAX_MOVE
    when 'left'
      @x_coord -= 1 if @x_coord > MIN_MOVE
    end
  end
end
