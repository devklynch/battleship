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
end