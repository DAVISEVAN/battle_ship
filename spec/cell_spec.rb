require './lib/ship'
require './lib/cell'

RSpec.describe Cell do
  before :each do
    @cell = Cell.new("B4")
    @cruiser = Ship.new("Cruiser", 3)
  end

  describe '#initialize' do
    it 'exists' do
      expect(@cell).to be_a(Cell)
    end

    it 'has a coordinate' do
      expect(@cell.coordinate).to eq("B4")
    end

    it 'starts empty' do
      expect(@cell.ship).to be_nil
      expect(@cell.empty?).to eq(true)
    end
  end

  describe '#place_ship' do
    it 'can place a ship' do
      @cell.place_ship(@cruiser)
      expect(@cell.ship).to eq(@cruiser)
      expect(@cell.empty?).to eq(false)
    end
  end

  describe '#fire_upon' do
    it 'knows if it has been fired upon' do
      @cell.place_ship(@cruiser)
      expect(@cell.fired_upon?).to eq(false)
      @cell.fire_upon
      expect(@cell.fired_upon?).to eq(true)
    end

    it 'reduces health of the ship when fired upon' do
      @cell.place_ship(@cruiser)
      @cell.fire_upon
      expect(@cell.ship.health).to eq(2)
    end
  end

  describe '#render' do
    it 'can render' do
      expect(@cell.render).to eq(".")

      @cell.fire_upon
      expect(@cell.render).to eq("M")

      @cell_2 = Cell.new("C3")
      @cell_2.place_ship(@cruiser)
      expect(@cell_2.render).to eq(".")
      expect(@cell_2.render(true)).to eq("S")

      @cell_2.fire_upon
      expect(@cell_2.render).to eq("H")
      expect(@cruiser.sunk?).to be false

      @cruiser.hit
      @cruiser.hit
      expect(@cruiser.sunk?).to eq(true)
      expect(@cell_2.render).to eq("X")
    end
  end 
end
