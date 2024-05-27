require './spec/spec_helper'

RSpec.describe Board do
  before :each do
    @board = Board.new
    @cruiser = Ship.new("Cruiser", 3)
    @submarine = Ship.new("Submarine", 2)
  end

  describe '#initialize' do
    it 'exists' do
      expect(@board).to be_a Board
    end

    it "can create 16 cell objects" do
      expect(@board.cells).to be_a Hash
      expect(@board.cells.count).to be 16
    end
  end

  describe '#validate_coordinate?' do
    it 'can validate a coordinate' do
      expect(@board.validate_coordinate?("A1")).to be true
      expect(@board.validate_coordinate?("D4")).to be true
      expect(@board.validate_coordinate?("A5")).to be false
      expect(@board.validate_coordinate?("E1")).to be false
    end
  end

  describe '#validate_placement?' do
    it 'can validate ship coordinates match ship length' do
      expect(@board.valid_placement?(@cruiser, ["A1", "A2"])).to be false
      expect(@board.valid_placement?(@submarine, ["A2", "A3", "A4"])).to be false
    end

    it 'can validate ship coordinates are consecutive' do
      expect(@board.valid_placement?(@cruiser, ["A1", "A2", "A4"])).to be false
      expect(@board.valid_placement?(@submarine, ["A1", "C1"])).to be false
      expect(@board.valid_placement?(@cruiser, ["A3", "A2", "A1"])).to be false
      expect(@board.valid_placement?(@submarine, ["C1", "B1"])).to be false
    end

    it 'can validate ship coordinates are not diagonal' do
      expect(@board.valid_placement?(@cruiser, ["A1", "B2", "C3"])).to be false
      expect(@board.valid_placement?(@submarine, ["C2", "D3"])).to be false
    end

    it 'can validate valid ship placement' do
      expect(@board.valid_placement?(@submarine, ["A1", "A2"])).to be true
      expect(@board.valid_placement?(@cruiser, ["B1", "C1", "D1"])).to be true
    end
  end

  describe '#place' do
    it "can place a ship" do
      @board.place(@cruiser, ["A1", "A2", "A3"])    
      cell_1 = @board.cells["A1"]
      cell_2 = @board.cells["A2"]
      cell_3 = @board.cells["A3"]    

      expect(cell_1).to be_a(Cell)
      expect(cell_2).to be_a(Cell)
      expect(cell_3).to be_a(Cell)
      expect(cell_1.ship).to be_a(Ship)  
      expect(cell_2.ship).to be_a(Ship)  
      expect(cell_3.ship).to be_a(Ship)  
      expect(cell_3.ship).to eq(cell_2.ship) 
    end

    it "can validate a ship placement does not overlap" do
      @board.place(@cruiser, ["A1", "A2", "A3"])
      
      expect(@board.valid_placement?(@submarine, ["A1", "B1"])).to be false
    end
  end

  describe '#render' do
      it "renders the board" do
      @board.place(@cruiser, ["A1", "A2", "A3"])

      expected_board_2 = "  1 2 3 4 \nA S S S .\nB . . . .\nC . . . .\nD . . . .\n"
      expect(@board.render(true)).to eq(expected_board_2)

      @board.cells["A1"].fire_upon
      @board.cells["B2"].fire_upon

      expected_board_3 = "  1 2 3 4 \nA H S S .\nB . M . .\nC . . . .\nD . . . .\n"
      expect(@board.render(true)).to eq(expected_board_3)

      @cruiser.hit
      @cruiser.hit

      expected_board_4 = "  1 2 3 4 \nA X X X .\nB . M . .\nC . . . .\nD . . . .\n"
      expect(@board.render).to eq(expected_board_4)
    end
  end
end
