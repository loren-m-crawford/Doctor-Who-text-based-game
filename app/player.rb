require_relative 'data'
#require_relative 'game_intro.txt'

class Player
attr_accessor :z_coord, :x_coord, :y_coord

  def initialize
    @z_coord, @x_coord, @y_coord = 1, 0, 1
  end
end
