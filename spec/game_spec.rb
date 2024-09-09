require 'pry'
require './lib/ship'
require './lib/cell'
require './lib/board'
require './lib/game'

RSpec.describe Game do

    it ' can introduce a new game' do
    @game = Game.new

    @game.new_game
    expect(@game.computer_board).to be_an_instance_of(Board)
    expect(@game.player_board).to be_an_instance_of(Board)
    end

    'it can lay out computer ship placement' do
        
    end

end