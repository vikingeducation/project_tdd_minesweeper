require_relative 'player'
require_relative 'board'

class Minesweeper

  def initialize(board = nil)
    @player = Player.new
    @board = board || Board.new
    @board.place_mines
    @board.set_mined_neighbors_for_all_cells  
  end

  def game_loop
    loop do
      @board.render_grid
      move = @player.get_move
      @board.make_move(move.shift, move.shift)
      break if game_end?
    end

    @board.render_grid(true)
  end

  def game_end?
    if @board.victory? 
      @board.status_message = "You Win!"
      true
    elsif @board.revealed_mine? 
      @board.status_message = "BOOM!  Game Over!"
      true
    end   
  end

end

# m = Minesweeper.new
# m.game_loop