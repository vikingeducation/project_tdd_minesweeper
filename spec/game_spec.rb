# spec/game_spec.rb

require 'board'
require 'renderer'
require 'player'
require 'game'
include Minesweeper

describe "Game" do
  let (:game) { Game.new }

  describe "#initialize" do
    it "creates an instance of Game" do
      expect(game).to be_a(Game)
    end

    it "creates an instance of Player in the game" do
      expect(game.player).to be_a(Player)
    end

    it "creates an instance of Board in the game" do
      expect(game.board).to be_a(Board)
    end

    it "creates an instance of Renderer in the game" do
      expect(game.renderer).to be_a(Renderer)
    end

    it "accepts an optional argument to set the game board" do
      test_grid = Array.new(3) { Array.new(3) { Cell.new }}
      test_board = Board.new(test_grid)
      test_game = Game.new(test_board)

      expect(test_game.board).to eq(test_board)
    end
  end

  context "modifying instance variables" do
    it "does not allow @player to be modified after initialization" do
      expect { game.player = "Player" }.to raise_error(NoMethodError)
    end

    it "does not allow @board to be modified after initialiization" do
      expect { game.board = "Board" }.to raise_error(NoMethodError)
    end

    it "does not allow @renderer to be modified after initialization" do
      expect { game.renderer = "Renderer" }.to raise_error(NoMethodError)
    end
  end

  describe "#show_instructions" do
    it "shows game instructions to the player" do
      expect { game.show_instructions }.to output.to_stdout
    end
  end

  context "at the start of the game" do
    before(:each) do
      allow(game).to receive(:puts).and_return(nil)
      allow(game.renderer).to receive(:puts).and_return(nil)
      allow(game.renderer).to receive(:print).and_return(nil)
    end

    it "shows game instructions to the player" do
      expect(game).to receive(:show_instructions)
      game.setup
    end

    it "sets up the minefield with randomly-placed mines" do
      expect(game.board).to receive(:setup_minefield)
      game.setup
    end

    it "shows the initial minefield" do
      expect(game.renderer).to receive(:draw_grid)
      game.setup
    end

    it "shows the number of flags left" do
      expect(game.renderer).to receive(:show_flags_left)
      game.setup
    end
  end

  context "during every turn" do
    before(:each) do
      allow(game.player).to receive(:puts).and_return(nil)
      allow(game.player).to receive(:print).and_return(nil)
      allow(game.renderer).to receive(:puts).and_return(nil)
    end

    context "getting player input" do
      it "asks the player for coordinates, if player has chosen to clear" do
        allow(game.player).to receive(:gets).and_return('c', '1, 2')
        game.run_loop
        expect(game.player.last_move).to eq('c')
        expect(game.player.last_coords).to eq([1, 2])
      end

      it "asks the player for coordinates, if player has chosen to flag" do
        allow(game.player).to receive(:gets).and_return('f', '3, 4')
        game.run_loop
        expect(game.player.last_move).to eq('f')
        expect(game.player.last_coords).to eq([3, 4])
      end

      it "asks the player for coordinates, if player has chosen to unflag" do
        allow(game.player).to receive(:gets).and_return('u', '5, 6')
        game.run_loop
        expect(game.player.last_move).to eq('u')
        expect(game.player.last_coords).to eq([5, 6])
      end
    end

    context "clearing / flagging / unflagging cells" do
      let (:test_grid) { Array.new(3) { Array.new(3) { Cell.new } } }
      let (:test_board) { Board.new(test_grid) }
      let (:test_game) { Game.new(test_board) }

      before(:each) do
        allow(test_game.player).to receive(:puts).and_return(nil)
        allow(test_game.player).to receive(:print).and_return(nil)
        allow(game.renderer).to receive(:puts).and_return(nil)
      end

      it "clears the cell at the user-specified coordinate, if relevant" do
        allow(test_game.player).to receive(:gets).and_return('c', '0, 0')
        test_game.run_loop

        expect(test_game.board.cell_cleared?(0, 0)).to be true
      end

      it "flags the cell at the user-specified coordinate, if relevant" do
        allow(test_game.player).to receive(:gets).and_return('f', '1, 1')
        test_game.run_loop

        expect(test_game.board.cell_flagged?(1, 1)).to be true
      end

      it "unflags the cell at the user-specified coordinate, if relevant" do
        allow(test_game.player).to receive(:gets).and_return('f', '2, 2', 'u', '2, 2')
        
        test_game.run_loop
        test_game.run_loop

        expect(test_game.board.cell_flagged?(2, 2)).to be false
      end
    end

    # it "updates the game board, if necessary"

    # it "updates the number of flags left, if necessary"

    context "displaying current state of minefield / number of flags" do
      it "shows the current state of the minefield"

      it "shows the number of flags left"
    end
  end

  context "the player chooses to quit" do
    it "exits the game"
  end

  context "the player clears a mine" do
    it "reveals all mines in the minefield"

    it "shows a message indicating the player has lost"

    it "exits the game"
  end

  context "the player successfully clears all cells without mines" do
    it "shows the final game board"

    it "congratulates the player"

    it "exits the game"
  end
end