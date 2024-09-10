require 'pry'
require './lib/ship'
require './lib/cell'
require './lib/board'
require './lib/game'

RSpec.describe Game do
    before(:each) do
        @game = Game.new
    end

    it ' can introduce a new game' do
        @game.new_game
    
        expect(@game.computer_board).to be_an_instance_of(Board)
        expect(@game.player_board).to be_an_instance_of(Board)
    end

    it 'can lay out computer ship placement for the cruiser' do
        # Call the method that places the cruiser
        @game.computer_cruiser_placement
    
        # Check if the cruiser was placed on the board
        placed_coordinates = @game.computer_board.cells.select do |_, cell|
          cell.ship == @game.computer_cruiser
        end.keys
    
        # Expect the cruiser to be placed on exactly 3 cells (its size)
        expect(placed_coordinates.length).to eq(3)
        expect(@game.computer_board.valid_placement?(@game.computer_cruiser, placed_coordinates)).to be true
    end
end