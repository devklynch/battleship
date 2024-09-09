require 'pry'
class Game

    attr_reader :computer_board,
                :player_board,
                :computer_cruiser,
                :computer_submarine

    def initialize
        @computer_board = nil
        @player_board = nil
        @computer_cruiser = nil
        @computer_submarine = nil
    end

    def new_game
    p "Welcome to BATTLESHIP
Enter p to play. Enter q to quit."
    response = "p"
        if response == "p"
        @computer_board = Board.new
        @player_board = Board.new
        computer_submarine_placement
        computer_cruiser_placement
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



    def computer_submarine_placement
        @computer_submarine = Ship.new("Submarine", 2)
        orientation=["horizontal","vertical"].sample
        if orientation == "horizontal"
            column=[1,2,3].sample
            row=["A","B","C","D"].sample

            ship_coordinates=[row+column.to_s, row +(column+1).to_s]
            @computer_board.place(@computer_submarine,ship_coordinates)
        

        elsif orientation == "vertical"
            column=["1","2","3","4"].sample
            row=[65,66,67].sample
            ship_coordinates= [row.chr+column, (row+1).chr+column]
            #require "pry" ; binding.pry
            @computer_board.place(@computer_submarine,ship_coordinates)
        end
    end

    def computer_cruiser_placement
        @computer_cruiser = Ship.new("Cruiser", 3)
        orientation=["horizontal","vertical"].sample
        if orientation == "horizontal"
            column=[1,2].sample
            row=["A","B","C","D"].sample

            ship_coordinates=[row+column.to_s, row +(column+1).to_s, row+(column+2).to_s ]
            #@computer_board.place(@computer_cruiser,ship_coordinates)
        

        elsif orientation == "vertical"
            column=["1","2","3","4"].sample
            row=[65,66].sample
            ship_coordinates= [row.chr+column, (row+1).chr+column, (row+2).chr+column]
            #require "pry" ; binding.pry
            #@computer_board.place(@computer_cruiser,ship_coordinates)
        end
        if @computer_board.valid_placement?(@computer_cruiser,ship_coordinates) == true
            @computer_board.place(@computer_cruiser,ship_coordinates)
        else
            computer_cruiser_placement
        end
        #binding.pry
    end

    
end