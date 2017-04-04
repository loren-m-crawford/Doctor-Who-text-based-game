require_relative '../app/game'
require 'rspec'
require 'pry'

describe Game do
  before do
    @game = Game.new
  end

  describe "#get_player_move" do
    it "downcases and strips the user input" do
      expect(@game).to receive(:get_player_move).and_return('DOwN ')
      expect(@game).to receive(:check_move).with('down').once
      @game.get_player_move
    end
  end

  describe "#check_move" do
    it "does not call give_move_feedback if move valid" do
      move  = StringIO.new("righ").string
      standardized_move = StringIO.new("right").string
      expect(@game).to receive(:give_move_feedback).never
      expect(@game).to receive(:move_player).with(standardized_move).once

      @game.check_move(move)
    end

    it "calls give_move_feedback if move not valid" do
      move = 'around'
      expect(@game).to receive(:give_move_feedback).once

      @game.check_move(move)
    end
  end
end
