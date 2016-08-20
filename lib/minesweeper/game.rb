module Minesweeper
  # Handles running and end cases
  class Game
    attr_reader :view, :board
    def initialize(board = nil)
      @view = Minesweeper::View.new
      @board = board || Minesweeper::Board.new
    end

    def run
      puts @view.welcome_message
      sleep(0.7)
      until finish?
        @board.render
        get_input
      end
      @board.render
      ending_message
    end

    private

    def ending_message
      puts view.victory_message if @board.complete?
      puts view.lose_message if @board.boom?
    end

    def finish?
      @board.complete? || @board.boom?
    end

    def get_input
      options = { "\e[A" => :up, "\e[B" => :down, "\e[D" => :left, "\e[C" => :right, 'f' => :flag, 'q' => :quit, ' ' => :reveal }
      input = read_char
      options.include?(input) ? @board.receive_input(options[input]) : get_input
    end

    # code from: https://gist.github.com/acook/4190379
    def read_char
      STDIN.echo = false
      STDIN.raw!

      input = STDIN.getc.chr
      if input == "\e"
        begin
          input << STDIN.read_nonblock(3)
        rescue
          nil
        end
        begin
          input << STDIN.read_nonblock(2)
        rescue
          nil
        end
      end
    ensure
      STDIN.echo = true
      STDIN.cooked!

      return input
    end
  end
end
