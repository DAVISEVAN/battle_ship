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
    if show_ship
      if fired_upon? && empty?
        "M"
      elsif fired_upon? && !empty?
        "H"
      elsif @ship != nil && @ship.sunk?
        "X"
      else
        !@ship.nil? ? "S" : "."
      end
    elsif @ship != nil && @ship.sunk?
      "X"
    elsif fired_upon? && !empty?
      "H"
    elsif fired_upon? && empty?
      "M"      
    else
      "."
    end
  end
end