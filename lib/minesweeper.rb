require_relative "board.rb"
require_relative "player.rb"


class Minesweeper # Game flow

  def initialize

    @board = Board.new
    @player = Player.new(@board)

  end

  def play

    print_instructions
    @board.render
    loop do
      move = @player.get_move
      @board.render
      break if game_over?(move)
    end
    say_goodbye
  end

  def game_over?(tile)

    player_win? || hit_mine?(tile)

  end

  def hit_mine?(tile)

    hit_a_mine = tile.is_mine && tile.is_cleared
    if hit_a_mine
      @board.reveal_mines
      puts "BOOM! Oh no. You've hit a mine! :("
      puts "Better luck next time!"
    end
    hit_a_mine

  end

  def player_win?

    tiles = @board.game_state.flatten
    victory = tiles.all? { |tile|
      tile.is_cleared ||
      tile.is_mine
    }

    puts "Congratulations!!!! You must be a master minesweeper!" if victory

    victory

  end

  def say_goodbye

    puts "Thank you for playing! Goodbye."

  end

  def print_instructions

    puts "------------------------------------------"
    puts "Welcome to Minesweeper"
    puts "To win, clear the board while avoiding all mines"
    puts "You can quit at any time by pressing 'q'"
    puts "------------------------------------------"

  end


end
