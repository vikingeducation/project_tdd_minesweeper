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




class Minesweeper


end


class Board

  attr_accessor :board

  def initialize

    @board = create_board

  end

  def create_board

    Array.new(10) {Array.new(10, "-")}

  end

  def generate_bombs

    @bombs = []

    until @bombs.length == 9
      current_bomb = [rand(0..9),rand(0..9)]
      @bombs << current_bomb unless @bombs.include?(current_bomb)
    end

    @bombs

  end



end
