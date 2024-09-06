require './lib/ship'
require './lib/cell'
require './lib/board'

RSpec.describe Board do
    before(:each) do
        @board = Board.new
    end
    it 'Board exists' do
        expect(@board).to be_an_instance_of(Board)
        expect(@board.cells).to be_an_instance_of(Hash)
    end

    it 'has cells' do
        expect(@board.cells).to be_an_instance_of(Hash)
        #maybe we can test with checking that there are 16 key/value pairs
    end

    it 'can validate coordinates' do
        expect(@board.valid_coordinate?("A1")).to eq(true)
        expect(@board.valid_coordinate?("D4")).to eq(true)
        expect(@board.valid_coordinate?("A5")).to eq(false)
        expect(@board.valid_coordinate?("E1")).to eq(false)
        expect(@board.valid_coordinate?("A22")).to eq(false)
    end

    it 'can validate placements' do 
        @cruiser = Ship.new("Cruiser", 3)
        @submarine = Ship.new("Submarine", 2)

        expect(@board.valid_placement?(cruiser, ["A1", "A2"])).to eq false
        expect(@board.valid_placement?(submarine, ["A1", "C1"])).to eq false
        expect(@board.valid_placement?(cruiser, ["A3", "A2", "A1"])).to eq false
        expect(@board.valid_placement?(submarine, ["C1", "B1"])).to eq false   
    end
end
