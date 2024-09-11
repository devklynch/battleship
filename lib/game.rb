require 'pry'
class Game
    attr_reader :computer_board,
                :player_board,
                :computer_cruiser,
                :computer_submarine,
                :player_cruiser,
                :player_submarine,
                :player_target

    def initialize
        @computer_board = Board.new
        @player_board = Board.new
        @computer_cruiser = Ship.new("Cruiser", 3)
        @computer_submarine = Ship.new("Submarine", 2)
        @player_cruiser = Ship.new("Cruiser", 3)
        @player_submarine = Ship.new("Submarine", 2)
        @turns = 1
    end

    def new_game
        puts "Welcome to BATTLESHIP
            Enter p to play. Enter q to quit."
        response = gets.chomp.downcase

        if response == "p"
            computer_submarine_placement
            computer_cruiser_placement
            place_player_ship

            until (@player_cruiser.sunk? && @player_submarine.sunk?) || (@computer_cruiser.sunk? && @computer_submarine.sunk?)
                player_turn
                puts
                puts "---NEW TURN---"
                puts
                computer_turn
            end

            if (@player_cruiser.sunk? && @player_submarine.sunk?)
                puts "Game over, Computer wins!"
            else
                puts "Game over, You win!"
            end
            # new_game
            system("ruby runner.rb")
        elsif response == "q"
            puts "Are you sure you want to quit? (Y/N)"
            response = gets.chomp.to_s.capitalize
            if response == "N" || response == "No"
                new_game
            else
                puts "You have left the game"
            end
        end
    end

    def place_player_ship
        puts "I have laid out my ships on the grid."
        puts "You now need to lay out your two ships."
        puts "The Cruiser is three units long and the Submarine is two units long."
        puts "#{@player_board.render}"
        puts 
        puts "Please give coordinates for Cruiser (3 spaces)"
        user_input = gets.chomp.upcase.split
        until @player_board.valid_placement?(@player_cruiser, user_input)
            puts "Those are not valid coordinates"
            user_input = gets.chomp.upcase.split
        end
        @player_board.place(@player_cruiser, user_input)
        puts "Player has placed Cruiser on #{user_input}"
        puts
        puts "Please give coordinates for Submarine (2 spaces)"
        user_input = gets.chomp.upcase.split
        until @player_board.valid_placement?(@player_submarine, user_input)
            puts "Those are not valid coordinates"
            user_input = gets.chomp.upcase.split
        end
        @player_board.place(@player_submarine, user_input)
        puts "Player has placed Submarine on #{user_input}"
        puts
    end

    def computer_submarine_placement
        orientation = ["horizontal", "vertical"].sample
        if orientation == "horizontal"
            column = [1, 2, 3].sample
            row = ["A", "B", "C", "D"].sample

            ship_coordinates = [row + column.to_s, row + (column + 1).to_s]
            @computer_board.place(@computer_submarine, ship_coordinates)
        
        elsif orientation == "vertical"
            column = ["1", "2", "3", "4"].sample
            row = [65, 66, 67].sample
            ship_coordinates = [row.chr + column, (row + 1).chr + column]
            @computer_board.place(@computer_submarine, ship_coordinates)
        end
    end

    def computer_cruiser_placement
        orientation = ["horizontal", "vertical"].sample
        if orientation == "horizontal"
            column = [1, 2].sample
            row = ["A", "B", "C", "D"].sample

            ship_coordinates = [row + column.to_s, row + (column + 1).to_s, row + (column + 2).to_s]
        
        elsif orientation == "vertical"
            column = ["1", "2", "3", "4"].sample
            row = [65, 66].sample
            ship_coordinates = [row.chr + column, (row + 1).chr + column, (row + 2).chr + column]
        end
        
        if @computer_board.valid_placement?(@computer_cruiser, ship_coordinates)
            @computer_board.place(@computer_cruiser, ship_coordinates)
        else
            computer_cruiser_placement
        end
    end

    def player_turn
        puts "_____Computer Board____"
        puts @computer_board.render(false)
        puts
        puts "_____Player Board____"
        puts 
        puts @player_board.render(true)
        puts
        puts "Enter the coordinates for your shot! Turn = #{@turns}"
        puts
        @player_target = gets.chomp.upcase
        
        until @computer_board.valid_coordinate?(@player_target) &&!@computer_board.cells[@player_target].fired_upon?
            puts "Cell #{@player_target} has already been fired on or is invalid. Please give new coordinates"
            @player_target = gets.chomp.upcase
        end
    
        @computer_board.cells[@player_target].fire_upon
    
        puts "Player has fired upon #{@player_target}"
        puts
    
        if @computer_board.cells[@player_target].empty?
            puts "Player fires at #{@player_target} and missed!"
            puts
        elsif @computer_board.cells[@player_target].ship.sunk?
            puts "Player fires at #{@player_target} and sinks #{@computer_board.cells[@player_target].ship.name}!"
            puts
        else
            puts "Player fires at #{@player_target} and hits!"
            puts
        end
        @turns += 1
    end

    def computer_turn
        computer_target = @player_board.cells.keys.sample
        until !@player_board.cells[computer_target].fired_upon?
            computer_target = @player_board.cells.keys.sample
        end
        @player_board.cells[computer_target].fire_upon

        if @player_board.cells[computer_target].empty?
            puts "Computer fires at #{computer_target} and missed!"
            puts
        elsif @player_board.cells[computer_target].ship.sunk?
            puts "Computer fires at #{computer_target} and sinks #{@player_board.cells[computer_target].ship.name}!"
            puts
        elsif (!@computer_cruiser.sunk? && !@computer_submarine.sunk?)
            puts "Computer fires at #{computer_target} and hits!"
            puts
        end
    end
end