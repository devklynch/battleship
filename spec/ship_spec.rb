require './lib/ship'

RSpec.describe Ship do
    before(:each) do
        @cruiser = Ship.new("Cruiser", 3)
    end 

    it 'Ship exists and has attributes' do
       expect(@cruiser).to be_an_instance_of(Ship)
       expect(@cruiser.name).to eq("Cruiser")
       expect(@cruiser.length).to eq(3)
    end

    it 'Can determine ship health' do
        expect(@cruiser.health).to eq(3)        
    end

    it 'Can check if its sunk?' do
        expect(@cruiser.sunk?).to eq(false)
    end

    it 'Can lose health' do
        @cruiser.hit
        expect(@cruiser.health).to eq(2)

        @cruiser.hit
        expect(@cruiser.health).to eq(1)
    end

    it 'Can sink' do
        @cruiser.hit
        @cruiser.hit
        expect(@cruiser.sunk?).to eq(false)
        @cruiser.hit
        expect(@cruiser.sunk?).to eq(true)
    end
    
end