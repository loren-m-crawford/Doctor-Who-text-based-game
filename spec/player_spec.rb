require_relative '../app/player'
require_relative '../app/room'
require_relative '../app/game'
require 'rspec'
require 'pry'
require 'spec_helper'

describe Player do
  before do
    @player= Player.new
    @room = Room.new(@player)
  end

  describe '#where_am_i' do
    it 'gives player their location' do
      floor = @player.z_coord
      room = @room.room_number
      allow(@room).to receive(:room_number).and_return(5)

      expect(@player.where_am_i).to eq("You're on floor #{floor}, by room #{room}.")
    end
  end

  describe 'enter_room' do

  end

  describe '#move' do
    context 'standardized_move is forward' do
      before do
        @move = 'forward'
      end
      context 'a player can move forward' do
        it 'changes players y_coord by +1' do
          @player.y_coord = 0
          @player.move(@move)

          expect(@player.y_coord).to eq 1
        end
      end

      context 'a player cannot move forward' do
        it 'does not change players y_coord' do
          @player.y_coord = 2
          @player.move(@move)

          expect(@player.y_coord).to eq 2
        end
      end
    end

    context 'standardized_move is backward' do
      before do
        @move = 'backward'
      end
      context 'a player can move backward' do
        it 'changes players y_coord by -1' do
          @player.y_coord = 1
          @player.move(@move)

          expect(@player.y_coord).to eq 0
        end
      end

      context 'a player cannot move backward' do
        it 'does not change players y_coord' do
          @player.y_coord = 0
          @player.move(@move)

          expect(@player.y_coord).to eq 0
        end
      end
    end

    context 'standardized_move is right' do
      before do
        @move = 'right'
      end
      context 'a player can move right' do
        it 'changes players x_coord by 1' do
          @player.x_coord = 1
          @player.move(@move)

          expect(@player.x_coord).to eq 2
        end
      end

      context 'a player cannot move right' do
        it 'does not change players x_coord' do
          @player.x_coord = 2
          @player.move(@move)

          expect(@player.x_coord).to eq 2
        end
      end
    end

    context 'standardized_move is left' do
      before do
        @move = 'left'
      end
      context 'a player can move left' do
        it 'changes players x_coord by -1' do
          @player.x_coord = 1
          @player.move(@move)

          expect(@player.x_coord).to eq 0
        end
      end

      context 'a player cannot move left' do
        it 'does not change players x_coord' do
          @player.x_coord = 0
          @player.move(@move)

          expect(@player.x_coord).to eq 0
        end
      end
    end

    context 'standardized_move is up' do
      before do
        @move = 'up'
      end
      context 'a player can move up a floor' do
        it 'changes players z_coord by +1' do
          @player.z_coord = 0
          @player.move(@move)

          expect(@player.z_coord).to eq 1
        end
      end

      context 'a player cannot move up a floor' do
        it 'does not change players z_coord' do
          @player.z_coord = 2
          @player.move(@move)

          expect(@player.z_coord).to eq 2
        end
      end
    end

    context 'standardized_move is down' do
      before do
        @move = 'down'
      end
      context 'a player can move down a floor' do
        it 'changes players z_coord by -1' do
          @player.z_coord = 2
          @player.move(@move)

          expect(@player.z_coord).to eq 1
        end
      end

      context 'a player cannot move down a floor' do
        it 'does not change players z_coord' do
          @player.z_coord = 0
          @player.move(@move)

          expect(@player.z_coord).to eq 0
        end
      end
    end
  end
end
