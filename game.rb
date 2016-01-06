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
    puts "This is a text-based game is based on the penultimate episode of the ninth series of \nDoctor Who episode, 'Heaven Sent', where the Doctor finds himself transported to a \nwaterlocked castle with a vieled monster seeking to kill him if he doesn't confess \nwhat he knows (thanks Steven Moffat)."

    puts " 
          _____|#|_____
         |_____________|      Welcome! 
        |_______________|     You are the Doctor in search for room 12.
      |||_POLICE_##_BOX_|||   You've just been transported to a three story castle. 
       | |¯|¯|¯|||¯|¯|¯| | 
       | |-|-|-|||-|-|-| |    As you move through the castle, you will find numbered
       | |_|_|_|||_|_|_| |    rooms that are locked. To unlock a room you must answer a 
       | ||~~~| | |¯¯¯|| |    question; if you answer it correctly, you will get a hint
       | ||~~~|!|!| O || |    as to where room 12 is. If you answer incorrectly the door
       | ||~~~| |.|___|| |    will not open and you must move on. Some rooms are not locked.
       | ||¯¯¯| | |¯¯¯|| |
       | ||   | | |   || |    You may move backward, forward, right, left, up a floor, or 
       | ||___| | |___|| |    down a floor.
       | ||¯¯¯| | |¯¯¯|| |    
       | ||   | | |   || |    Which direction would you like to go in first?
       | ||___| | |___|| |     
      |¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯|   Please type in 'backward', 'forward', 'right', 'left', 'up',
                              or 'down.'
      "

    get_player_move
  end

  def get_player_move
     while ROOMS[[@player.z_coord,@player.x_coord,@player.y_coord]]['room number'] != 12 
      move = gets.chomp.downcase.strip
      if MOVES.include?(move)  
       move_player(move)
       puts "\n"
      else
        puts "That's not a valid move. Please type in 'backward', 'forward', 'right', 'left', 'up', and 'down.'"
      end 
    end
  end

  def move_player(move)
    @world.send("move_player_#{move}", @player)
  end
end

#######################################################

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

  def move_player_up(player)
    if player.z_coord < FLOORS - 1
      player.z_coord += 1 
      puts 'You just moved up a floor.'
      @room.enter_room(player.z_coord,player.x_coord,player.y_coord)
    else
      puts "You can't move up a floor. Try another direction."
    end 
  end

  def move_player_down(player)
    if player.z_coord > 0
      player.z_coord -= 1 
      puts 'You just moved down a floor.'
      @room.enter_room(player.z_coord,player.x_coord,player.y_coord)
    else
      puts "You can't move down a floor. Try another direction."
    end
  end
end

############################################
class Room
  attr_accessor :z_coord, :x_coord, :y_coord 

  def enter_room(z_coord,x_coord,y_coord)
    if ROOMS[[z_coord, x_coord, y_coord]]['locked'] == false
      get_room_num(z_coord,x_coord,y_coord)
      puts "This room is not locked or has been unlocked. Rooms that are not locked don't provide hints. Keep searching--select a direction."
    elsif ROOMS[[z_coord, x_coord, y_coord]]['room number'] != 12 
      get_room_num(z_coord,x_coord,y_coord)
      get_lock_status(z_coord,x_coord,y_coord)
      get_room_question(z_coord,x_coord,y_coord)
      get_player_answer(z_coord,x_coord,y_coord)
    else
      puts "Congratulations!"
      puts "You've reached room 12.\n Rassilon put you in your confession dial in order to gain information about the Hybrid. \n Now you must remove Rassilon from Gallifrey and find out why he need the information. \n"
      puts "You're next journey awaits!"
      puts ' 
                         _-_
                        |   |
                   .  .       .   .  
                .                    .
             .          |^|     /_\     .
          .       / \   | |     | |       .
        .    _    | |  /   \   /   \        .
      .     | |   | | /     \ /     \         .
    .      /   \ /   \|     | |     |     / \   .
   .      /     /     \     | |     |     | |    .
  .        |   ||     |     |/       \    | |     .
 .         |   ||     |     /         \  /   \     .
.          |   ||     |     |         | /     \     .
.      |   |   ||   GALLIFREY         | |     |     .
.     / \ /    /       \    |         | |     |     .
.     | | |   /      *  \   |         |  \   /      .
.     | |/    |     / \ |   /         \   | |       .
 .   /   \    |     | | |   |         |   | |      .
  . /     \   |     | | |   |         |   | |     .  
   .|     |   |     | | |   |         |   | |    .
    .     |   |     | | |   |         |   | |   .
     .    |   |     | | |   |         |   | |  .
       .  |   |     | | |   |         |   | |.
         .    |     | | |  /           \  .    
              .  .  .  .  .  .  .  .  .
              '
    end
  end

  def get_lock_status(z_coord,x_coord,y_coord)
    locked = ROOMS[[z_coord, x_coord, y_coord]]['locked']
    if locked == true
      puts "This room is locked. To get a hint you've got to answer this question." 
    end 
  end

  def get_room_num(z_coord,x_coord,y_coord) 
    room_num = ROOMS[[z_coord, x_coord, y_coord]]['room number']
    if room_num.is_a?Fixnum 
      puts "You are about to enter room #{room_num}."
    else
      puts "You're about to enter the #{room_num}."
    end
  end

  def get_room_question(z_coord,x_coord,y_coord)
    room_ques = ROOMS[[z_coord, x_coord, y_coord]]['question']
    puts "\n"
    puts "#{room_ques }\n"
  end

  def get_player_answer(z_coord,x_coord,y_coord)
    positive_feedback = [
      'Correct!',"You must be a mad man with a box, because that's correct!", 
      "Did you just pretend that was a plan? Well it worked!",
      "Aren't you a right good Whovian!?", 
      "Well done! That wasn't wibbly wobbly at all! :)"]
    answer = gets.chomp.strip
    if answer.downcase === ROOMS[[z_coord, x_coord, y_coord]]['answer']
      ROOMS[[z_coord, x_coord, y_coord]]['locked'] = false
      puts '|||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||'
      puts positive_feedback.sample
      puts '----------------------------------------------------------------------'
      puts "    Here's a hint to help you find room 12:"
      get_hint(z_coord,x_coord,y_coord)
    else
      puts "That's not right. Keep looking for room 12."
    end
  end

  def get_hint(z_coord,x_coord,y_coord)
    hint = ROOMS[[z_coord, x_coord, y_coord]]['hint']
    puts "    #{hint}"
    puts '----------------------------------------------------------------------'
    puts "Keep searching." 
  end
end 

############################################

class Player
attr_accessor :z_coord, :x_coord, :y_coord 

  def initialize
    @z_coord, @x_coord, @y_coord = 1, 0, 1
  end
end

############################################
Game.new
