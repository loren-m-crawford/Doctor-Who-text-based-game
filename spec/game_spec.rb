require_relative '../app/game'
require_relative '../app/player'
require 'rspec'
require 'pry'
require 'spec_helper'

describe Game do
  before do
    @game = Game.new
  end

  describe '#new' do
    it 'returns game introduction text' do
      expect(File).to receive(:read).with("game_intro.txt") 
      @game.game_intro
    end
  end

  describe "#get_player_move" do
    before do
      $stdin = StringIO.new("DOwN ")
    end

    after do
      $stdin = STDIN
    end

    it "downcases and strips the user input" do
      expect(@game).to receive(:check_move).with('down')
      @game.get_player_move
    end
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
  end

  describe "#check_move" do
    before { allow(@game).to receive(:get_player_answer).and_return('the silence') }
    context 'player starts at [1,0,1]' do
      it 'tells player the room and asks question' do
        @game.check_move('up')
        expect(@game.player.coordinates).to eq ([2,0,1])
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
