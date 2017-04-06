require_relative '../app/player'
require_relative '../app/room'
require_relative '../app/game'
require 'rspec'
require 'pry'
require 'spec_helper'

describe Room do

  before do
    @game = Game.new
    @player = Player.new(@game)
    @room = Room.new(@player)
    allow(@room).to receive(:coordinates).and_return([0,0,1])
  end

  describe '#winning_room?' do
    context 'room number is 12' do
      it 'returns true' do
        allow(@room).to receive(:coordinates).and_return([0,0,2])
        expect(@room.winning_room?).to be true
      end
    end

    context 'room number is not 12' do
      it 'return false' do
        expect(@room.winning_room?).to be false
      end
    end
  end

  describe '#question' do
    it 'retreives question from data' do
      question = 'What is the name of the scientist who created the Daleks?'
      expect(@room.question).to eq question
    end
  end

  describe '#answer' do
    it 'retrieves answer from data' do
      answer = 'davros'
      expect(@room.answer).to eq answer
    end
  end

  describe '#hint' do
    it 'retrieves hint from data' do
      hint = 'Go forward to find what you seek.'
      expect(@room.hint).to eq hint
    end
  end
end
