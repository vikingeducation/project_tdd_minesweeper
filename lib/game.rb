class Game
  attr_accessor :app_state

  def initialize
    @app_state = {
      board: Array.new(10){ Array.new(10) },
      mines: 9
    }
  end

  # ----------------------------------------------------------------------
  # app state
  # ----------------------------------------------------------------------

  def board
    app_state[:board]
  end

  def mines
    app_state[:mines]
  end

  def plant_mines
    rows, cols = board.length, board[0].length
    (0...mines).reduce([]) do |acc, i|
      x, y = rand(0...rows), rand(0...cols)
      acc << [x, y]
    end
  end

  def render(msgs)
    # we preppend a \n for aesthetic reaons
    if msgs.is_a?(Array)
      msgs.each_with_index do |msg, i|
        puts if i == 0
        puts msg
      end
    else
      puts "\n#{msgs}"
    end
  end


end
