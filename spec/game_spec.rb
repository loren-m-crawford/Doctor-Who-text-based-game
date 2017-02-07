require_relative '../game'
require 'rspec'
require 'pry'

describe Game do
  before do
    @game = Game.new
  end

  describe "check_move" do
    it "does not call give_move_feedback if move valid" do
      move = 'rig'
      actual_move = 'right'
      expect(@game).to receive(:give_move_feedback).never
      expect(@game).to receive(:move_player).with(actual_move).once

      @game.check_move(move)
    end

    it "calls give_move_feedback if move not valid" do
      move = 'around'
      expect(@game).to receive(:give_move_feedback).once

      @game.check_move(move)
    end
  end
end
