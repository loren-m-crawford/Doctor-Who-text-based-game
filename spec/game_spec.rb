require_relative '../app/game'
require_relative '../app/player'
require_relative '../app/data'
require 'rspec'
require 'pry'
require 'spec_helper'

describe Game do
  before do
    @game = Game.new
  end
  #
  # describe '#new' do
  #   it 'returns game introduction text' do
  #     expect(File).to receive(:read).with("game_intro.txt") 
  #     @game.game_intro
  #   end
  # end

  describe "#get_player_move" do
    context 'user provides move' do
      before { $stdin = StringIO.new("DOwN ") }
      after { $stdin = STDIN } 

      it "downcases and strips the user input" do
        expect(@game).to receive(:check_move).with('down')
        @game.get_player_move
      end
    end

    # context 'user provides exit as input' do
    #   before { $stdin = StringIO.new("exit") }
    #   after { $stdin = STDIN } 
    #   it "exits the game if user puts 'exit'" do
    #     expect(@game).to receive(:check_move).never
    #     @game.get_player_move
    #   end
    # end
  end

  describe '#get_player_answer' do
    before do
      $stdin = StringIO.new("DocTor WhO ")
    end

    after do
      $stdin = STDIN
    end

    it 'downcases and strips user input' do
      expect(@game).to receive(:check_answer).with('doctor who')
      @game.get_player_answer
    end
  end

  describe '#print_question' do
    before do
      $stdin = StringIO.new("up")
      @game.player.z_coord, @game.player.x_coord, @game.player.y_coord = 0,0,1
    end

    after { $stdin = STDIN }

    it 'prints the player the room and question they are in' do
      output = "You're in #{@game.player_room.room_number}. Here's your question: #{@game.player_room.question}"
      expect { @game.print_question }.to output(output).to_stdout
    end
  end

  describe '#play' do
    context 'player reaches the winning room' do
      before do
        $stdin = StringIO.new("forward")
        @game.player.z_coord, @game.player.x_coord, @game.player.y_coord = 0,0,1
      end

      after { $stdin = STDIN }

      it 'changes the players position' do
        @game.play
        expect(@game.player.coordinates).to eq [0,0,2]
      end
    end
  end

  describe "#check_move" do
    context 'user gives actual move' do
      it 'standardizes user input' do
        move = 'down'
        expect(@game).to receive(:give_move_feedback).never
        @game.check_move(move)
      end
    end

    context 'user provides incomplete move' do
      it "returns standardized input" do
        move = "righ"
        expect(@game).to receive(:give_move_feedback).never
        @game.check_move(move)
      end
    end

    context 'user provides an incorrect move' do
      it 'gives user feedback on moves' do
        move = "geronimo"
        expect(@game).to receive(:give_move_feedback).once
        @game.check_move(move)
      end
    end
  end

end
