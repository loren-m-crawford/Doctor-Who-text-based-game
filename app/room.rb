require_relative 'data'
#require_relative 'game_intro.txt'

class Room

  attr_reader :coordinates

  def initialize(player)
    @coordinates = [player.z_coord, player.x_coord, player.y_coord]
  end

  def room_number
    ROOMS[coordinates][:room_number]
  end

  def question
    ROOMS[coordinates][:question]
  end

  def answer
    ROOMS[coordinates][:answer]
  end

  def hint
    ROOMS[coordinates][:hint]
  end

  def winning_room?
    room_number == 12
  end
end
#       puts "Congratulations!"
#       puts "You've reached room 12.\n Rassilon put you in your confession dial in order to gain information about the Hybrid. \n Now you must remove Rassilon from Gallifrey and find out why he need the information. \n"
#       puts "You're next journey awaits!"
#       puts '
#                          _-_
#                         |   |
#                    .  .       .   .
#                 .                    .
#              .          |^|     /_\     .
#           .       / \   | |     | |       .
#         .    _    | |  /   \   /   \        .
#       .     | |   | | /     \ /     \         .
#     .      /   \ /   \|     | |     |     / \   .
#    .      /     /     \     | |     |     | |    .
#   .        |   ||     |     |/       \    | |     .
#  .         |   ||     |     /         \  /   \     .
# .          |   ||     |     |         | /     \     .
# .      |   |   ||   GALLIFREY         | |     |     .
# .     / \ /    /       \    |         | |     |     .
# .     | | |   /      *  \   |         |  \   /      .
# .     | |/    |     / \ |   /         \   | |       .
#  .   /   \    |     | | |   |         |   | |      .
#   . /     \   |     | | |   |         |   | |     .
#    .|     |   |     | | |   |         |   | |    .
#     .     |   |     | | |   |         |   | |   .
#      .    |   |     | | |   |         |   | |  .
#        .  |   |     | | |   |         |   | |.
#          .    |     | | |  /           \  .
#               .  .  .  .  .  .  .  .  .
#               '
#     end
#   end
#
#   def get_lock_status(z_coord,x_coord,y_coord)
#     locked = ROOMS[[z_coord, x_coord, y_coord]]['locked']
#     if locked == true
#       puts "This room is locked. To get a hint you've got to answer this question."
#     end
#   end
#
#     positive_feedback = [
#       'Correct!',"You must be a mad man with a box, because that's correct!",
#       "Did you just pretend that was a plan? Well it worked!",
#       "Aren't you a right good Whovian!?",
#       "Well done! That wasn't wibbly wobbly at all! :)"]
#     if answer.downcase === ROOMS[[z_coord, x_coord, y_coord]]['answer']
#       ROOMS[[z_coord, x_coord, y_coord]]['locked'] = false
#       puts '|||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||'
#       puts positive_feedback.sample
#       puts '----------------------------------------------------------------------'
#       puts "    Here's a hint to help you find room 12:"
#       get_hint(z_coord,x_coord,y_coord)
#     else
#       puts "That's not right. Keep looking for room 12."
#     end
#   end
#
