require 'pry'
class Game

    attr_reader :computer_board,
                :player_board

    def initialize
        @computer_board = nil
        @player_board = nil
    end

    def new_game
    p "Welcome to BATTLESHIP
Enter p to play. Enter q to quit."
    response = "p"
        if response == "p"
        @computer_board = Board.new
        @player_board = Board.new
        "You are now playing the game"
        elsif response == "q"
            "You are not playing the game"
        end
    end

    def place_player_ship
        p "I have laid out my ships on the grid.
You now need to lay out your two ships.
The Cruiser is three units long and the Submarine is two units long. #{@player_board.render}"
    end
end