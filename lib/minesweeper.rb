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



end
