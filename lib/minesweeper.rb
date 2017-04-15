class MineSweeper
  def initialize(ui:, board:)
    @ui = ui
    @board = board
  end

  def play
    cell_coordinates = []
    cell_action = ''

    loop do
      cell_coordinates = ui.get_cell_choice
      break if board.valid_move?(cell_coordinates)
      ui.invalid_move
    end

    loop do
      cell_action = ui.get_cell_action
      break if board.valid_action?(cell_action)
      ui.invalid_action
    end

    board.make_move(cell_coordinates, cell_action)
  end

  private

  attr_reader :ui, :board
end