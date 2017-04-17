require_relative 'lib/board'
require_relative 'lib/command_line_ui'
require_relative 'lib/cell'
require_relative 'lib/minesweeper'
require_relative 'lib/errors'

ui = CommandLineUI.new
board = Board.new

game = MineSweeper.new(ui: ui, board: board)
game.play
