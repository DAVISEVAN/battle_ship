class Game
  attr_reader :player_board, 
              :computer_board, 
              :player_ships, 
              :computer_ships
              
  def initialize
    @player_board = Board.new
    @computer_board = Board.new
    @player_ships = []
    @computer_ships = []
  end

  def start
    main_menu
  end

  def main_menu
    puts "Welcome to BATTLESHIP"
    puts "Enter p to play. Enter q to quit."

    input = gets.chomp.downcase
    if input == 'p'
      setup
      play_game
    elsif input == 'q'
      puts "Goodbye!"
    else
      puts "Invalid option. Please enter p to play or q to quit."
      main_menu
    end
  end

  private

  def setup
    
    place_computer_ships

    # Information for player ship placement
    puts "I have laid out my ships on the grid."
    puts "You now need to lay out your two ships."
    puts "The Cruiser is three units long and the Submarine is two units long."

    place_player_ships
  end

  def play_game
    until game_over?
      turn
    end
    end_game
  end

  def turn
    display_boards
    player_shot
    computer_shot
  end

  def end_game
    if @player_board.all_ships_sunk?
      puts "I won!"
    else
      puts "You won!"
    end
    main_menu
  end

  def place_computer_ships
    @computer_ships << Ship.new("Cruiser", 3)
    @computer_ships << Ship.new("Submarine", 2)

    @computer_ships.each do |ship|
      placed = false
      until placed
        coordinates = @computer_board.cells.keys.sample(ship.length) 
        if @computer_board.valid_placement?(ship, coordinates)
          @computer_board.place(ship, coordinates)
          placed = true
        end
      end
    end
  end

  def place_player_ships
    @player_ships << Ship.new("Cruiser", 3)
    @player_ships << Ship.new("Submarine", 2)

    @player_ships.each do |ship|
      placed = false
      until placed
        puts @player_board.render(true)
        puts "Enter the squares for the #{ship.name} (#{ship.length} spaces):"
        input = gets.chomp.upcase.split
        if @player_board.valid_placement?(ship, input)
          @player_board.place(ship, input)
          placed = true
        else
          puts "Those are invalid coordinates. Please try again."
        end
      end
    end
  end

  def display_boards
    puts "=============COMPUTER BOARD============="
    puts @computer_board.render
    puts "==============PLAYER BOARD=============="
    puts @player_board.render(true)
  end

  def player_shot
    puts "Enter the coordinate for your shot:"
    valid_shot = false
    until valid_shot
      coordinate = gets.chomp.upcase
      if @computer_board.validate_coordinate?(coordinate) && !@computer_board.cells[coordinate].fired_upon?
        @computer_board.cells[coordinate].fire_upon
        display_shot_result(@computer_board, coordinate, "Your")
        valid_shot = true
      else
        puts "Please enter a valid coordinate:"
      end
    end
  end

  def computer_shot
    valid_shot = false
    until valid_shot
      coordinate = @player_board.cells.keys.sample
      unless @player_board.cells[coordinate].fired_upon?
        @player_board.cells[coordinate].fire_upon
        display_shot_result(@player_board, coordinate, "My")
        valid_shot = true
      end
    end
  end

  def display_shot_result(board, coordinate, shooter)
    result = board.cells[coordinate].render
    case result
    when 'M'
      puts "#{shooter} shot on #{coordinate} was a miss."
    when 'H'
      puts "#{shooter} shot on #{coordinate} was a hit."
    when 'X'
      puts "#{shooter} shot on #{coordinate} sunk a ship!"
    end
  end

  def game_over?
    @player_board.all_ships_sunk? || @computer_board.all_ships_sunk?
  end
end


  