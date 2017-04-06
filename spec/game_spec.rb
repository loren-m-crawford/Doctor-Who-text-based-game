require_relative '../app/game'
require_relative '../app/player'
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
      expect(@game.get_player_answer).to eq 'doctor who'
    end
  end

  describe '#play' do
    #TODO
  end

  describe "#check_move" do
    context 'user gives actual move' do
      before { $stdin = StringIO.new("down") }
      it 'standardizes user input' do
        expect(@game).to receive(:give_move_feedback).never
        @game.get_player_move
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
