class MineSweeper
  VALID_ACTIONS = %w(c cleared).freeze

  def initialize(ui:, board:)
    @ui = ui
    @board = board
    @game_over = false
  end

  def play
    until game_over? do

      coordinates = action = ''
      begin
        loop do
          begin
            ui.display_board(board)
            coordinates = ui.get_cell_choice
            action = ui.get_cell_action
            break
          rescue StandardError => error
            puts "\n#{error.message}\n"
          end
        end

        make_move(coordinates, action)
      rescue StandardError => error
        puts "\n#{error.message}\n"
        @game_over = true
      end

    end

    puts 'You lose'
  end

  private

  attr_reader :ui, :board

  def game_over?
    @game_over
  end

  def make_move(coordinates, action)
    validate_action(action)

    if board.valid_move?(coordinates)
      board.record_move(coordinates, action)
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