class CommandLineUI
  def initialize
    @presenter = ShellPresenter.new
  end

  def display_board(board)
    presenter.red_message("\n#{board.to_s}")
  end

  def error_feedback(msg)
    presenter.red_message("\n#{msg}\n")
  end

  def get_cell_action
    presenter.green_message("What would you like to do? (c)lear or (f)lag\n: ")
    gets.chomp.downcase
  end

  def get_cell_choice
    presenter
      .green_message('Enter row and column coordinates, separated by a comma (eg 1,2): ')

    gets.chomp.downcase
  end

  def player_lost(msg)
    presenter.red_message("\n#{msg}. The game is over and you lost.")
  end

  private

  attr_reader :presenter
end
