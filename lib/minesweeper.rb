class MineSweeper
  VALID_ACTIONS = %w(c clear f flag).freeze

  def initialize(ui:, board:)
    @ui = ui
    @board = board
    @game_over = false
  end

  def play
    until game_over?

      coordinates = action = ''
      begin
        loop do
          begin
            ui.display_board(board)

            coordinates = ui.get_cell_choice
            validate_move(coordinates)

            action = ui.get_cell_action
            validate_action(action)
            break
          rescue StandardError => error
            ui.error_feedback(error.message)
          end
        end

        make_move(coordinates, action)
      rescue StandardError => error
        ui.player_lost(error.message)
        @game_over = true
      end

      @game_over = true unless board.flags_left?
    end
  end

  private

  attr_reader :ui, :board

  def game_over?
    @game_over
  end

  def make_move(coordinates, action)
    board.record_move(coordinates, action)
  end

  def validate_move(coordinates)
    unless board.cell_available?(coordinates)
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