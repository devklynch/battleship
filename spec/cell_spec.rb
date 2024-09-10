require './lib/ship'
require './lib/cell'

RSpec.describe Cell do
    before(:each) do
        @cell = Cell.new("B4")
    end

    it 'Cell exists and has attributes' do
        expect(@cell).to be_an_instance_of(Cell)
        expect(@cell.coordinate).to eq("B4")
    end

    it 'can contain a ship' do
        expect(@cell.ship).to eq(nil)
    end

    it 'can check if its empty' do
        expect(@cell.empty?).to eq(true)
    end

    it 'can place ship' do
        @cruiser = Ship.new("Cruiser", 3)
        @cell.place_ship(@cruiser)

        expect(@cell.ship).to eq(@cruiser)
        expect(@cell.empty?).to eq(false)
    end
###Tests Devlin added
    it 'can check if its fired upon' do
        @cruiser = Ship.new("Cruiser", 3)
        @cell.place_ship(@cruiser)

        expect(@cell.fired_upon?).to eq(false)
    end

    it 'can be fired upon' do
        @cruiser = Ship.new("Cruiser", 3)
        @cell.place_ship(@cruiser)

        @cell.fire_upon
        
        expect(@cell.ship.health).to eq(2)
        expect(@cell.fired_upon?).to eq(true)
    end

    it 'can render if the cell has not been fired upon' do
        @cruiser = Ship.new("Cruiser", 3)
        
        expect(@cell.render).to eq(".")
        
        @cell.fire_upon
        expect(@cell.render).to eq("M")
    end

    it 'can reveal a ship in the cell even if it has been fired upon' do
        @cell_2 = Cell.new("C3")
        @cruiser = Ship.new("Cruiser", 3)
        @cell_2.place_ship(@cruiser)
        expect(@cell_2.render).to eq(".")
        expect(@cell_2.render(true)).to eq("S")
    end

    it 'can render if the cell has been fired upon contains a ship' do
        @cell_2 = Cell.new("C3")
        @cruiser = Ship.new("Cruiser", 3)
        @cell_2.place_ship(@cruiser)

        @cell_2.fire_upon
        expect(@cell_2.render).to eq("H")
    end

    it 'can render if the cell has been fired upon and its ship has been sunk' do
        @cell_2 = Cell.new("C3")
        @cruiser = Ship.new("Cruiser", 3)
        @cell_2.place_ship(@cruiser)
        @cell_2.fire_upon

        expect(@cruiser.sunk?).to eq(false)

        @cruiser.hit
        @cruiser.hit
        expect(@cruiser.sunk?).to eq(true)
        expect(@cell_2.render).to eq("X")
    end

end