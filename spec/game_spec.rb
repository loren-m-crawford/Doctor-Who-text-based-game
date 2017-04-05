require_relative '../app/game'
require_relative '../app/player'
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
      expect(@game).to receive(:check_move).with('down')
      @game.get_player_move
    end
  end

  describe "#check_move" do
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

  describe '#forward' do
    context 'user provides forward input' do
      it 'returns +1 ' do
        expect(@game.forward).to eq 1
      end
    end

    describe '#backward' do
      context 'user provides backward input' do
        it 'returns -1' do
          expect(@game.backward).to eq -1
        end
      end
    end

    describe '#right' do
      context 'user provides right input' do
        it 'returns -1' do
          expect(@game.right).to eq 1
        end
      end
    end

    describe '#left' do
      context 'user provides left input' do
        it 'returns -1' do
          expect(@game.left).to eq -1
        end
      end
    end
  end

  describe '#check_room_number' do
    context 'room number is not 12' do
      it 'returns true' do
        expect(@game.check_room_number).to be true
      end
    end

    context 'room number is 12' do
      before do
        allow_any_instance_of(Player).to receive(:room_number).and_return(12)
      end
      it 'return false' do
        expect(@game.check_room_number).to be false
      end
    end
  end
end
