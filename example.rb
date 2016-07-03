#Board
#Minesweeper board has 2D array of Squares (10x10 - default)
#Minesweeper board also initialized to have 9 flags
#num_flag counter on the board is init to num of mines, decremented on every flag marked
#Square
#Initially all the Squares are hidden, later it is made visible
#Each Square might be empty or might have a mine (9 mines - default)
#Each Square is marked as cleared or flaged by the player
#Player
#When the player flags a Square, the num_flag counter on the board is decremented
#Player marks a Square as cleared or flaged.
#GameLogic or Board
#When player marks a Square as cleared and it it is cleared, that Square is visible and shows number of mines surrounding it.
#Also, neighboring Squares are made visible until the Squares with atleast 1 mine as neighbor
#When a player marks a Square as cleared and if it has a mine, game is over and all the mines are made visible.
#Player wins when all the flags are guessed correctly and num_flags == 0
require_relative "lib/board.rb"
require_relative "lib/square.rb"
require_relative "lib/player.rb"
require_relative "lib/game.rb"

Game.new.play

