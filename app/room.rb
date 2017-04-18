require_relative 'data'
#require_relative 'game_intro.txt'

class Room

  attr_reader :coordinates

  def initialize(player)
    @coordinates = player.coordinates
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
