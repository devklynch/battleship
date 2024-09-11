require 'pry'
require './lib/ship'
require './lib/cell'
require './lib/board'

RSpec.describe Board do
    before(:each) do
        @board = Board.new   
    end

    it 'Board exists and has cells' do
        expect(@board).to be_an_instance_of(Board)
        expect(@board.cells).to be_an_instance_of(Hash)
        expect(@board.cells.keys.count).to eq(16)
        expect(@board.cells.values.first).to be_an_instance_of(Cell)
    end

    it 'can validate coordinates' do
        expect(@board.valid_coordinate?("A1")).to eq(true)
        expect(@board.valid_coordinate?("D4")).to eq(true)
        expect(@board.valid_coordinate?("A5")).to eq(false)
        expect(@board.valid_coordinate?("E1")).to eq(false)
        expect(@board.valid_coordinate?("A22")).to eq(false)
    end

    describe 'can validate placements' do 
        before(:each) do
        @cruiser = Ship.new("Cruiser", 3)
        @submarine = Ship.new("Submarine", 2)
    end

        it 'checks the array is the same length as the ship' do
            expect(@board.valid_placement?(@cruiser, ["A1", "A2"])).to eq false
            expect(@board.valid_placement?(@submarine, ["A2", "A3", "A4"])).to eq false
        end
        
        it 'checks that the coordinates are consecutive' do
            expect(@board.valid_placement?(@submarine, ["A1", "C1"])).to eq false
            expect(@board.valid_placement?(@cruiser, ["A1", "A2", "A4"])).to eq false
            expect(@board.valid_placement?(@cruiser, ["A3", "A2", "A1"])).to eq false
            expect(@board.valid_placement?(@submarine, ["C1", "B1"])).to eq false 
        end

        it 'checks that coordinates are not diagonal' do
            expect(@board.valid_placement?(@cruiser, ["A1", "B2", "C3"])).to eq false
            expect(@board.valid_placement?(@submarine, ["C2", "D3"])).to eq false 
        end

        it' can check for valid placements' do
            #require "pry" ; binding .pry
            expect(@board.valid_placement?(@cruiser, ["B1", "C1", "D1"])).to eq true
            expect(@board.valid_placement?(@submarine, ["A1", "A2"])).to eq true
            #require "pry" ; binding.pry
        end
    end

    it 'can place ships with valid placements' do
        @cruiser = Ship.new("Cruiser", 3)
        @board.place(@cruiser, ["A1", "A2", "A3"])
        @cell_1=@board.cells["A1"] 
        @cell_2=@board.cells["A2"] 
        @cell_3=@board.cells["A3"] 
        expect(@cell_1.ship).to eq(@cell_2.ship)
        expect(@cell_2.ship).to eq(@cell_3.ship)
    end

    it 'can confirm ships can only be placed on open cells' do
        @cruiser = Ship.new("Cruiser", 3)
        @board.place(@cruiser, ["A1", "A2", "A3"])
        @submarine = Ship.new("Submarine", 2)
        expect(@board.valid_placement?(@submarine, ["A1", "B1"])).to eq(false)
    end

    it 'can render an empty board' do
        @cruiser = Ship.new("Cruiser", 3)
        @board.place(@cruiser, ["A1", "A2", "A3"])
        expect(@board.render).to eq(" 1 2 3 4 \nA . . . . \nB . . . . \nC . . . . \nD . . . . \n")
        expect(@board.render(true)).to eq(" 1 2 3 4 \nA S S S . \nB . . . . \nC . . . . \nD . . . . \n")
    end

    it 'can be fired upon cell, and test for new render' do
        @cruiser = Ship.new("Cruiser", 3)
        @board.place(@cruiser, ["A1", "A2", "A3"])
        @board.cells["A1"].fire_upon
        @board.cells["B4"].fire_upon
        @board.cells["C1"].fire_upon
        @board.cells["D1"].fire_upon           
        expect(@board.render).to eq(" 1 2 3 4 \nA H . . . \nB . . . M \nC M . . . \nD M . . . \n")
    end
end
