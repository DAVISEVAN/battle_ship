require './lib/ship'

RSpec.describe Ship do
  before :each do
    @cruiser = Ship.new("Cruiser", 3)
  end

  describe '#initialize' do
    it 'exists' do
      expect(@cruiser).to be_a(Ship)
    end

    it 'has a name' do
      expect(@cruiser.name).to eq("Cruiser")
    end

    it 'has a length' do
      expect(@cruiser.length).to eq(3)
    end

    it 'starts with full health' do
      expect(@cruiser.health).to eq(3)
    end
  end

  describe '#hit' do
    it 'can take a hit' do
      @cruiser.hit
      expect(@cruiser.health).to eq(2)
    end
  end

  describe '#sunk?' do
  it 'can be sunk' do
    @cruiser.hit
    @cruiser.hit
    expect(@cruiser.sunk?).to eq(false)
    @cruiser.hit
    expect(@cruiser.sunk?).to eq(true)
    end
  end
end