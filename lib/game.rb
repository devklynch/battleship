require 'pry'
class Game
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

#     def new_game
#     p "Welcome to BATTLESHIP
# Enter p to play. Enter q to quit."
#     response = gets.chomp
#         if response == "p"
#         computer_submarine_placement
#         computer_cruiser_placement
#         place_player_ship
#         elsif response == "q"
#             "You are not playing the game"
#         end
#     end
    def new_game
        p "Welcome to BATTLESHIP
            Enter p to play. Enter q to quit."
            response= gets.chomp
            if response == "p"
                computer_submarine_placement
                computer_cruiser_placement
                place_player_ship
            elsif response == "q"
                "You are not playing the game"
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
        user_input = gets.chomp.split
        until @player_board.valid_placement?(@player_cruiser,user_input)
            p "Those are not valid coordinates"
            user_input = gets.chomp.split
        end
        @player_board.place(@player_cruiser, user_input)
        p "Player has placed Cruiser on #{user_input}"
        
        p "Please give coodinates for Submarine(2 spaces)"
        user_input = gets.chomp.split
        until @player_board.valid_placement?(@player_submarine,user_input)
            p "Those are not valid coordinates"
            user_input = gets.chomp.split
        end
        @player_board.place(@player_submarine,user_input)
        p "Player has placed Cruiser on #{user_input}"
    end



    def computer_submarine_placement
#    def computer_placement(ship)
        # random_coordinates = @computer_board.cells.keys.sample(3)

        # until @computer_board.valid_placement?(@computer_submarine,random_coordinates) 
        #     random_coordinates = @computer_board.cells.keys.sample(3)
        # end
        # @computer_board.place(@computer_submarine,random_coordinates)
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
        #require "pry" ; binding.pry
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