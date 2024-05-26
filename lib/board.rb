class Board
    attr_reader :cells
  
    def initialize
      @cells = create_cells
    end
  
    def create_cells
      cells = {}
      ("A".."D").each do |letter|
        (1..4).each do |number|
          coordinate = letter + number.to_s
          cells[coordinate] = Cell.new(coordinate)
        end
      end
      cells
    end
  
    def validate_coordinate?(coordinate)
      @cells.key?(coordinate)
    end
  
    def valid_placement?(ship, coordinates)
      return false unless coordinates.all? { |coord| validate_coordinate?(coord) }
      return false unless coordinates.size == ship.length
      return false unless consecutive_coordinates?(coordinates)
  
      coordinates.none? { |coord| !@cells[coord].empty? }
    end
  
    def consecutive_coordinates?(coordinates)
      letters = coordinates.map { |coord| coord[0] }
      numbers = coordinates.map { |coord| coord[1].to_i }
  
      consecutive?(letters) && numbers.uniq.size == 1 ||
        consecutive?(numbers) && letters.uniq.size == 1
    end
  
    def consecutive?(arr)
      arr.each_cons(2).all? { |a, b| b == a.next }
    end
  
    def place(ship, coordinates)
      if valid_placement?(ship, coordinates)
        coordinates.each { |coord| @cells[coord].place_ship(ship) }
        true
      else
        false
      end
    end    
  
    def render(reveal = false)
      rows = ["  1 2 3 4 "]
      ("A".."D").each do |letter|
        row = "#{letter} "
        (1..4).each do |number|
          coordinate = "#{letter}#{number}"
          row += @cells[coordinate].render(reveal) + " " 
        end
        rows << row.strip
      end
      rows.join("\n") + "\n"
    end              
end
  