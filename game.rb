require_relative 'data'
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
      move = gets
      move.downcase.strip
  end

  def check_move(move)
    if MOVES.find do |x|
     move = x if /#{move}/ =~ x
    end
    move_player(move)
    else
      give_move_feedback
    end
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

  def move_player(move)
    puts move
    #@world.send :"move_player_#{move}", @player
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
