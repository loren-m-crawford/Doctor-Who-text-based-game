class World
	floors = 3
	rooms_per_floor_width = 3
	rooms_per_floor_height = 3

	def initialize
    @castle = []
    floors.times do 
    	@castle << Array.new(rooms_per_floor_height, Array.new(rooms_per_floor_width))
    end
  end

  def move_player_forward(player)
    player.y_coord -= 1 if player.y_coord > 0
  end

  def move_player_backward(player)
    player.y_coord += 1 if player.y_coord < floor_height - 1
  end

  def move_player_right(player)
    player.x_coord += 1 if player.x_coord < floor_width - 1
  end

  def move_player_left(player)
    player.x_coord -= 1 if player.x_coord > 0
  end

  def move_player_up_floor(player)
  	player.z_coord += 1 if player.z_coord < floors - 1
  end

  def move_player_down_floor(player)
  	player.z_coord -= 1 if player.z_coord > 0
  end

  def get_room_of(player)
    @rooms[player.z_coord][player.x_coord][player.y_coord] ||= Room.new
  end

end

############################################

class Room
	attr_accessor :size, :content

	def initialize
    @locked = get_lock_status
  end

  def get_lock_status
  	
  end

end 

############################################

class Player

	def initialize
    @z_coord, @x_coord, @y_coord = 1, 1, 0
  end
end
