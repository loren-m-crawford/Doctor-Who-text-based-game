class Room
  attr_accessor :locked, :room_ques, :room_num, :hint, :z_coord, :x_coord, :y_coord 

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
             .          |^|     /_\    .
          .       / \   | |     | |      .
        .    _    | |  /   \   /   \       .
      .     | |   | | /     \ /     \        .
    .      /   \ /   \|     | |     |     / \  .
   .      /     /     \     | |     |     | |   .
  .        |   ||     |     |/       \    | |    .
 .         |   ||     |     /         \  /   \    .
.          |   ||     |     |         | /     \    .
.      |   |   ||   GALLIFREY         | |     |    .
.     / \ /    /       \    |         | |     |    .
.     | | |   /      *  \   |         |  \   /     .
.     | |/    |     / \ |   /         \   | |      .
 .   /   \    |     | | |   |         |   | |     .
  . /     \   |     | | |   |         |   | |    . 
   .|     |   |     | | |   |         |   | |   .
    .     |   |     | | |   |         |   | |  .
     .    |   |     | | |   |         |   | | .
       .  |   |     | | |   |         |   | .
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