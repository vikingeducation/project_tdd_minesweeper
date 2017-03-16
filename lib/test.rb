if $0 == __FILE__
  require_relative './game'
  include Minesweeper

  grid = Array.new(3) { Array.new(3) { Cell.new } }
  grid[1][1].mine = true
  board = Board.new(grid)
  game = Game.new(board)
  game.setup
  game.run_loop
end