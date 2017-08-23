module Minesweeper
  class Game
    attr_reader :board, :renderer

    def initialize(board: Board.new, renderer: Renderer.new)
      @board = board
      @renderer = renderer
      @prompt = TTY::Prompt.new
    end

    def start
      display_intro

      until over?
        render_board(:active)
        input = get_user_input
        @board.public_send(input[:action], *input[:row_and_column])
      end

      puts @board.all_cleared? ? 'Game over! You won!' : 'Game over! You loss'
      render_board(:over)
    end

    private

    def display_intro
      puts 'hello world'
    end

    def render_board(state)
      puts @renderer.render(@board, state)
    end

    def get_user_input
      {action: get_action, row_and_column: get_row_and_column}
    end

    def get_action
      @prompt.ask("Action? (f to flag|c to clear)") do |q|
        q.required true
        q.validate(-> (input) {input.match(/\A[fc]\Z/i) && !(input.downcase == 'f' && @board.flags_remaining <= 0) }, 'Invalid action or no more flags remaning.')
        q.convert(-> (input) { input.downcase == 'f' ? :flag : :clear })
      end
    end

    def get_row_and_column
      loop do
        last_index = @board.size - 1

        row_column = %w(row column).map do |coordinate|
          @prompt.ask("#{coordinate} number 0-#{last_index}") do |q|
            q.required true
            q.validate(/\A[0-#{last_index}]\Z/, "#{coordinate} must be a number between 0 and #{last_index}")
            q.convert :int
          end
        end

        break(row_column) if @board.valid_move?(*row_column)
      end
    end

    def over?
      @board.cleared_mine? || @board.all_cleared?
    end
  end
end
