require 'pry'
class Board
    attr_reader :cells

    def initialize
        @cells = {
                "A1" => Cell.new("A1"),
                "A2" => Cell.new("A2"),
                "A3" => Cell.new("A3"),
                "A4" => Cell.new("A4"),
                "B1" => Cell.new("B1"),
                "B2" => Cell.new("B2"),
                "B3" => Cell.new("B3"),
                "B4" => Cell.new("B4"),
                "C1" => Cell.new("C1"),
                "C2" => Cell.new("C2"),
                "C3" => Cell.new("C3"),
                "C4" => Cell.new("C4"),
                "D1" => Cell.new("D1"),
                "D2" => Cell.new("D2"),
                "D3" => Cell.new("D3"),
                "D4" => Cell.new("D4"),
                }
    end

    def valid_coordinate?(coordinate)
        @cells[coordinate] != nil
    end

    def valid_placement?(ship,coordinates)
        ship.length == coordinates.length && coordinates.all? {|coordinate| cells[coordinate].empty?} &&
        ((horizontal_check(ship,coordinates)&& !vertical_check(ship,coordinates)) ||
        (vertical_check(ship,coordinates) && !horizontal_check(ship,coordinates)))
    end

    def horizontal_check(ship,coordinates)
        nums_board= [1,2,3,4].each_cons(ship.length).to_a
        letters = []
        nums = []
        coordinates.each do |coordinate|
            letters << (coordinate[0]).ord
            nums <<(coordinate[1]).to_i
        end
        letters.uniq.length == 1 && nums_board.include?(nums)
    end

    def vertical_check(ship,coordinates)
        letters_board= [65,66,67,68].each_cons(ship.length).to_a
        letters = []
        nums = []
        coordinates.each do |coordinate|
            letters << (coordinate[0]).ord
            nums <<(coordinate[1]).to_i
        end
        nums.uniq.length == 1 && letters_board.include?(letters)
    end

    def place(ship,coordinates)
        if valid_placement?(ship,coordinates)
            coordinates.each do |coordinate|
                cells[coordinate].place_ship(ship) 
            end
        end        
    end

    def render(render=false)
        header = " 1 2 3 4 \n" #Creating our top row
        rows = ["A", "B", "C", "D"] #Creating our letters for row
        
        board_string = rows.map do |row| #enumerating through each element assigning them their own "row_string"
            row_string = "#{row} " 
            (1..4).each do |num|
                coordinate = "#{row}#{num}"
                row_string += "#{@cells[coordinate].render(render)} "
            end
            row_string.strip + " \n"
        end.join
        header + board_string
    end
    
end