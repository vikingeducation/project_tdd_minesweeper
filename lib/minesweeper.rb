=begin

  Board
  -set up a board
    ORIGINAL STATE
    ----------  symbol for mine X
    ----------  numbers are numbers
    ----------  flags i
    ----------  empty spaces O
    ----------
    ----------
    ----------
    ----------
    ----------
    ----------

    FIRST MOVE

    OOOO------  symbol for mine X
    OO11------  numbers are numbers
    OO1i------  flags i
    ----------  empty spaces O
    ----------
    ----------
    ----------
    ----------
    ----------
    ----------


  minesweeper (game flow)

    initialize a player [minesweeper]
    initialize a board [minesweeper]

    start game loop [minesweeper]
      ask - check a field or put/remove flag
        ask for input (coordinates)
          validate that coordinate are in board
          check that the field isn't already check
          execute the move


  board
    create board
    render the board
    randomly create bombs but not place them

  player
    initialize a player
    handle input



=end

require_relative "board.rb"
require_relative "player.rb"


class Minesweeper

  def initialize

    @board = Board.new
    @player = Player.new(@board)

  end

  def play

    @board.render

    #Until game over(we hit a mine or we win)
    until game_over?

      # Ask type of action (place/remove flag, clear tile)
      tile = @player.get_move
      # Ask player for coordinates
      # Perform appropriate action
      # Render the board
      @board.render
    end

  end

  def game_over?

    

  end


end



