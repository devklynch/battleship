class Cell
    attr_reader :coordinate,
                :ship,
                :reveal

    def initialize(coordinate)
        @coordinate = coordinate
        @ship = nil
        @fired_upon = false
    end

    def empty?
        @ship == nil
    end

    def place_ship(ship)
        @ship = ship
    end

    def fired_upon?
        @fired_upon 
    end

    def fire_upon
        @fired_upon = true
        if @ship != nil
            @ship.hit
        end
    end

    def render(reveal=false)
        if reveal == true && @ship != nil
            "S"
        elsif @fired_upon == true && @ship == nil
            "M"
        elsif @fired_upon == true && @ship != nil
             if @ship.sunk? == false
                "H"
             else
                "X"
             end
        else
            "."
        end

    end

end