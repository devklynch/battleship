class Cell
    attr_reader :coordinate,
                :ship

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

    def render(show_ship = true)
        if @fired_upon
            if @ship & @ship.sunk?
                "X"
            elsif @ship
                "H"
            else
                "M"
            end
        else
            if show_ship && @ship
                "S"
            else
                "."
            end
        end
    end
end