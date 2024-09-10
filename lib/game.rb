require 'pry'
class Game

    attr_reader and initialize
attr_reader :computer_board,
                :player_board,
                :computer_cruiser,
                :computer_submarine,
                :player_cruiser,
                :player_submarine
    def initialize
        @computer_board = Board.new
        @player_board = Board.new
        @computer_cruiser = Ship.new("Cruiser", 3)
        @computer_submarine = Ship.new("Submarine", 2)
        @player_cruiser = Ship.new("Cruiser", 3)
        @player_submarine = Ship.new("Submarine", 2)
    end

    def new_game(response)
    p "Welcome to BATTLESHIP
        Enter p to play. Enter q to quit."
        if response = "p"
            computer_submarine_placement
            computer_cruiser_placement
            place_player_ship
        elsif response == "q"
            "You are not playing the game"
        end
    end

    def place_player_ship
        p "I have laid out my ships on the grid.You now need to lay out your two ships.\nThe Cruiser is three units long and the Submarine is two units long. #{@player_board.render}"

        p "Please give coodinates for Cruiser(3 spaces)"
        user_input = gets.chomp.downcase
        until @player_board.valid_placement?(@player_cruiser,user_input)
            p "Those are not valid coordinates"
            user_input = gets.chomp.downcase
        end
        @player_board.place(@player_cruiser,user_input)
        p "Player has placed Cruiser on #{user_input}"
        
        p "Please give coodinates for Submarine(2 spaces)"
        user_input = gets.chomp.downcase
        until @player_board.valid_placement?(@player_submarine,user_input)
            p "Those are not valid coordinates"
            user_input = gets.chomp.split
        end
        @player_board.place(submarine,user_input)
        p "Player has placed Cruiser on #{user_input}"
    end
end