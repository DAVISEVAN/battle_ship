require './spec/spec_helper'

RSpec.describe Game do
  before :each do
    @game = Game.new
  end

  describe '#initialize' do
    it 'exists' do
      expect(@game).to be_a Game
    end

    it 'has initialized attributes' do
      expect(@game.player_board).to be_a Board
      expect(@game.computer_board).to be_a Board
      expect(@game.player_ships).to eq []
      expect(@game.computer_ships).to eq []
    end
  end

end
