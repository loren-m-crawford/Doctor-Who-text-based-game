require_relative 'data.rb'

class Game
  MOVES = [
    'forward', 'backward', 'right', 'left', 'up', 'down'
  ]

  def initialize
    @world = World.new
    @player = Player.new

    start_game
  end

 private
  def start_game
  	puts "Welcome! You are the Doctor in search for room 12."
  	puts "You've just been transported to a three story castle. As you move through the castle, you will find numbered rooms that are locked. To unlock a room you must answer a question; if you answer it correctly, you will get a hint as to where room 12 is. If you answer incorrectly the door will not open and you must move on."
  	puts "You may move backward, forward, right, left, up, and down."
  	puts "Which direction would you like to go in first? Please type in 'backward', 'forward', 'right', 'left', 'up', and 'down.'"

    

    while @player.current_room_num != 12 
    	move = gets.chomp
     	if MOVES.include?(move)  
	   	 move_player(move)
	   	else
	   		puts "That's not a valid move. Please type in 'backward', 'forward', 'right', 'left', 'up', and 'down.'"
	  	end 
  	end
  end

	def move_player(move)
    case move
    when 'right'
      @world.move_player_right(@player)
    when 'left'
      @world.move_player_left(@player)
    when 'forward'
      @world.move_player_forward(@player)
    when 'backward'
      @world.move_player_backward(@player)
    when 'up'
      @world.move_player_up_floor(@player)
    when 'down'
      @world.move_player_down_floor(@player)
    end
  end
end

#########################################

class World
	FLOORS = 3
	ROOMS_PER_FLOOR_WIDTH = 3
	ROOMS_PER_FLOOR_HEIGHT = 3

	def initialize
		@room = Room.new
    @castle = []
    FLOORS.times do 
    	@castle << Array.new(ROOMS_PER_FLOOR_HEIGHT, Array.new(ROOMS_PER_FLOOR_WIDTH))
    end
  end

  def move_player_forward(player)
    player.y_coord += 1 if player.y_coord > 0
    puts 'You just moved forward.'
    puts "You are at [#{player.z_coord},#{player.x_coord},#{player.y_coord}]."
    @room.enter_room(player.z_coord,player.x_coord,player.y_coord)
  end

  def move_player_backward(player)
    player.y_coord -= 1 if player.y_coord < ROOMS_PER_FLOOR_HEIGHT - 1
    puts 'You just moved backward.'
    puts "You are at [#{player.z_coord},#{player.x_coord},#{player.y_coord}]."
    @room.enter_room(player.z_coord,player.x_coord,player.y_coord)
  end

  def move_player_right(player)
    player.x_coord += 1 if player.x_coord < ROOMS_PER_FLOOR_WIDTH - 1
    puts 'You just moved right.'
    puts "You are at [#{player.z_coord},#{player.x_coord},#{player.y_coord}]."
    @room.enter_room(player.z_coord,player.x_coord,player.y_coord)
  end

  def move_player_left(player)
    player.x_coord -= 1 if player.x_coord > 0
    puts 'You just moved left.'
    puts "You are at [#{player.z_coord},#{player.x_coord},#{player.y_coord}]."
    @room.enter_room(player.z_coord,player.x_coord,player.y_coord)
  end

  def move_player_up_floor(player)
  	player.z_coord += 1 if player.z_coord < FLOORS - 1
  	puts 'You just moved up a floor.'
    puts "You are at [#{player.z_coord},#{player.x_coord},#{player.y_coord}]."
    @room.enter_room(player.z_coord,player.x_coord,player.y_coord)
  end

  def move_player_down_floor(player)
  	player.z_coord -= 1 if player.z_coord > 0
  	puts 'You just moved down a floor.'
    puts "You are at [#{player.z_coord},#{player.x_coord},#{player.y_coord}]."
    @room.enter_room(player.z_coord,player.x_coord,player.y_coord)
  end

  
end

############################################

class Room
	attr_accessor :locked, :room_ques, :room_num, :hint, :z_coord, :x_coord, :y_coord 

	# def initialize
   
 #  end

  def enter_room(z_coord,x_coord,y_coord)
  	get_lock_status(z_coord,x_coord,y_coord)
  	get_room_question(z_coord,x_coord,y_coord)
  	get_player_answer(z_coord,x_coord,y_coord)
  end

  def get_lock_status(z_coord,x_coord,y_coord)
  	locked = ROOMS[[z_coord, x_coord, y_coord]]['locked']
  	if locked == true
  		puts "This room is locked. You must answer a question." 
  	else
  		puts "This room is not locked."
  	end 
  end

  def get_room_question(z_coord,x_coord,y_coord)
  	room_ques = ROOMS[[z_coord, x_coord, y_coord]]['question']
  	print room_ques
  end

  def get_player_answer(z_coord,x_coord,y_coord)
  	answer = gets.chomp
  	if answer.downcase === ROOMS[[z_coord, x_coord, y_coord]]['answer']
  		get_hint(z_coord,x_coord,y_coord)
  	else
  		puts "That's not right. Keep looking for room 12."
  	end
  end

  def get_hint(z_coord,x_coord,y_coord)
  	hint = ROOMS[[z_coord, x_coord, y_coord]]['hint']
  	puts "You've answered correctly. Your hint is: #{hint} Keep looking for room 12." 
  end
end 

############################################

class Player
attr_accessor :z_coord, :x_coord, :y_coord 

	def initialize
    @z_coord, @x_coord, @y_coord = 1, 1, 0
  end

  def current_room_num
  	ROOMS[[@z_coord,@x_coord,@y_coord]]['room number']
  end 
end

############################################
Game.new
