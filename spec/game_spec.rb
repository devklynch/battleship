require 'pry'
require './lib/ship'
require './lib/cell'
require './lib/board'
require './lib/game'

RSpec.describe Game do

    it ' can introduce a new game' do
        @game = Game.new

        @game.new_game("p")
        expect(@game.computer_board).to be_an_instance_of(Board)
        expect(@game.player_board).to be_an_instance_of(Board)
    end

    it 'can place a ship in a valid placement'

    result = @game.place_player_ship(cruiser_coordinates,submarine_coordinates)

    expect(result).to eq('true')

end