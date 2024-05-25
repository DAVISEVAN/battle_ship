class Cell 
  attr_reader :coordinate, :ship

  def initialize(coordinate)
    @coordinate = coordinate
    @ship = nil
    @counter = 0
  end

  def empty?
    @ship == nil
  end

  def place_ship(ship)
    @ship = ship
  end

  def fired_upon?
    @counter == 1
  end
  
  def fire_upon
    @counter +=1 
    if @ship != nil
      @ship.hit
    end
  end

  def render(show_ship = false)
    if show_ship == true
      "S"
    elsif fired_upon? == false
      "."
    elsif fired_upon? == true && @ship == nil
      "M"
    elsif @ship.sunk? == true
      "X"
    else fired_upon? == true && @ship != nil
      "H"
    end
  end

end