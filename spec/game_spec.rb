require_relative '../app/game'
require 'rspec'
require 'pry'
require 'spec_helper'

describe Game do
  before do
    @game = Game.new
    $stdin = StringIO.new("DOwN ")
  end

  after do
    $stdin = STDIN
  end

  describe "#get_player_move" do
    it "downcases and strips the user input" do
      expect(@game).to receive(:get_player_move).and_return('down')
      @game.get_player_move
    end
  end

  describe "#check_move" do
    context 'user provides incomplete move' do
      it "returns standardized input" do
        move = "righ"
        expect(@game).to receive(:check_move).with("righ").and_return('right')
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
