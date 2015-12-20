class World
  attr_accessor :room
  FLOORS = 3
  ROOMS_PER_FLOOR_WIDTH = 3
  ROOMS_PER_FLOOR_HEIGHT = 3

  def initialize
    @room = Room.new
  end

  def move_player_forward(player)
    if player.y_coord < ROOMS_PER_FLOOR_HEIGHT - 1
      player.y_coord += 1 
      puts 'You just moved forward.'
      @room.enter_room(player.z_coord,player.x_coord,player.y_coord)
    else
      puts "You can't move forward. Try another direction."
    end
  end

  def move_player_backward(player)
    if player.y_coord > 0
      player.y_coord -= 1
      puts 'You just moved backward.'
      @room.enter_room(player.z_coord,player.x_coord,player.y_coord)
    else
      puts "You can't move backward. Try another direction."
    end 
  end

  def move_player_right(player)
    if player.x_coord < ROOMS_PER_FLOOR_WIDTH - 1
      player.x_coord += 1 
      puts 'You just moved right.'
      @room.enter_room(player.z_coord,player.x_coord,player.y_coord)
    else
      puts "You can't move right. Try another direction."
    end 
  end

  def move_player_left(player)
    if player.x_coord > 0 
      player.x_coord -= 1 
      puts 'You just moved left.'
      @room.enter_room(player.z_coord,player.x_coord,player.y_coord)
    else
      puts "You can't move left. Try another direction."
    end 
  end

  def move_player_up_floor(player)
    if player.z_coord < FLOORS - 1
      player.z_coord += 1 
      puts 'You just moved up a floor.'
      @room.enter_room(player.z_coord,player.x_coord,player.y_coord)
    else
      puts "You can't move up a floor. Try another direction."
    end 
  end

  def move_player_down_floor(player)
    if player.z_coord > 0
      player.z_coord -= 1 
      puts 'You just moved down a floor.'
      @room.enter_room(player.z_coord,player.x_coord,player.y_coord)
    else
      puts "You can't move down a floor. Try another direction."
    end
  end
end