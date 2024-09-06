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
end
