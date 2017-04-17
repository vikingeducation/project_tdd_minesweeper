class MineSweeper
  VALID_ACTIONS = %w(c cleared).freeze

  def initialize(ui:, board:)
    @ui = ui
    @board = board
  end

  def play
    cell_coordinates = []
    cell_action = ''

    loop do
      begin
        ui.display_board(board)
        cell_coordinates = ui.get_cell_choice
        cell_action = ui.get_cell_action
        make_move(cell_coordinates, cell_action)
        break
      rescue StandardError => error
        puts error.message
      end
    end
  end

  private

  attr_reader :ui, :board

  def make_move(coordinates, action)
    validate_action(action)

    if board.valid_move?(coordinates)
      board.record_move
    else
      raise Errors::UnavailableCellError,
            'Those coordinates are incorrect. Start again.'
    end
  end

  def validate_action(action)
    unless VALID_ACTIONS.include? action.downcase
      raise Errors::IllegalActionError,
            'That action is illegal. Start again.'
    end
  end
end