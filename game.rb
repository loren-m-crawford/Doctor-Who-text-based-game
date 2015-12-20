Dir["*.rb"].each {|file| require_relative file }

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
         |_____________|        Welcome! 
        |_______________|       You are the Doctor in search for room 12.
      |||_POLICE_##_BOX_|||   You've just been transported to a three story castle. 
       | |¯|¯|¯|||¯|¯|¯| | 
       | |-|-|-|||-|-|-| |    As you move through the castle, you will find numbered
       | |_|_|_|||_|_|_| |    rooms that are locked. To unlock a room you must answer a 
       | ||~~~| | |¯¯¯|| |    question; if you answer it correctly, you will get a hint
       | ||~~~|!|!| O || |    as to where room 12 is. If you answer incorrectly the door
       | ||~~~| |.|___|| |    will not open and you must move on.
       | ||¯¯¯| | |¯¯¯|| |
       | ||   | | |   || |    You may move backward, forward, right, left, up, and down.
       | ||___| | |___|| |
       | ||¯¯¯| | |¯¯¯|| |    Which direction would you like to go in first?
       | ||   | | |   || |
       | ||___| | |___|| |    Please type in 'backward', 'forward', 'right', 'left', 'up', 
      |¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯|   and 'down.'
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

############################################
Game.new
