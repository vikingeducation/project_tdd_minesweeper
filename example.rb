#Board
#Minesweeper board has 2D array of Cells (10x10 - default)
#Minesweeper board also initialized to have 9 flags
#num_flag counter on the board is init to num of mines, decremented on every flag marked
#Cell
#Initially all the cells are hidden, later it is made visible
#Each cell might be empty or might have a mine (9 mines - default)
#Each cell is marked as cleared or flaged by the player
#Player
#When the player flags a cell, the num_flag counter on the board is decremented
#Player marks a cell as cleared or flaged.
#GameLogic or Board
#When player marks a cell as cleared and it it is cleared, that cell is visible and shows number of mines surrounding it.
#Also, neighboring cells are made visible until the cells with atleast 1 mine as neighbor
#When a player marks a cell as cleared and if it has a mine, game is over and all the mines are made visible.
#Player wins when all the flags are guessed correctly and num_flags == 0