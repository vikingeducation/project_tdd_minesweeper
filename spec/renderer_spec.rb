# spec/renderer_spec.rb

require 'renderer'
require 'board'
include Minesweeper

describe "Renderer" do
  let (:renderer) { Renderer.new }

  describe "#initialize" do

    it "creates a Renderer" do
      expect(renderer).to be_a(Renderer)
    end

    it "sets the game board it's rendering to nil" do
      expect(renderer.board).to be_nil
    end

    it "accepts an optional parameter as the game board it will render" do
      test_board = instance_double("Board")
      test_renderer = Renderer.new(test_board)
      expect(test_renderer.board).to eq(test_board)
    end
  end

  describe "#board=" do
    it "allows the Renderer to be assigned a new board to display" do
      test_board = instance_double("Board")
      renderer.board = test_board
      expect(renderer.board).to eq(test_board)
    end
  end

  describe "#draw_grid" do
    let (:test_grid) { Array.new(3) { Array.new(3) { Cell.new } } }
    let (:test_board) { Board.new(test_grid) }

    it "correctly displays a board with all uncleared cells and no mines" do
      renderer.board = test_board
      expected_output = /0 1 2 \n\n. . . \t0\n. . . \t1\n. . . \t2\n/
      expect { renderer.draw_grid }.to output(expected_output).to_stdout
    end

    it "shows a cleared cell's adjacent mine count if it has adjacent mines" do
      test_board.grid[0][0].mine = true
      test_board.grid[2][2].mine = true
      renderer.board = test_board

      renderer.board.grid[1][1].adjacent_mine_count = renderer.board.adjacent_mines(1, 1)

      renderer.board.clear(1, 1)

      expected_output = /0 1 2 \n\n. . . \t0\n. 2 . \t1\n. . . \t2\n/
      expect { renderer.draw_grid }.to output(expected_output).to_stdout
    end

    it "shows a cleared cell as '0' if it does not have adjacent mines" do
      renderer.board = test_board

      renderer.board.grid[1][1].adjacent_mine_count = renderer.board.adjacent_mines(1, 1)

      renderer.board.clear(1, 1)

      expected_output = /0 1 2 \n\n. . . \t0\n. 0 . \t1\n. . . \t2\n/
      expect { renderer.draw_grid }.to output(expected_output).to_stdout
    end

    it "marks a flagged cell as flagged" do
      renderer.board = test_board

      renderer.board.grid[1][1].flag

      expected_output = /0 1 2 \n\n. . . \t0\n. F . \t1\n. . . \t2\n/
      expect { renderer.draw_grid }.to output(expected_output).to_stdout
    end

    it "does not reveal existing mines" do
      test_board.grid[1][1].mine = true
      renderer.board = test_board

      expected_output = /0 1 2 \n\n. . . \t0\n. . . \t1\n. . . \t2\n/
      expect { renderer.draw_grid }.to output(expected_output).to_stdout
    end

    context "if the player clears a mine" do  
      it "reveal all mines if the optional show_mines argument is true" do
        test_board.grid[0][0].mine = true
        test_board.grid[1][1].mine = true
        test_board.grid[2][2].mine = true
        test_board.clear(0, 0)
        
        renderer.board = test_board

        expected_output = /0 1 2 \n\nX . . \t0\n. X . \t1\n. . X \t2\n/
        expect { renderer.draw_grid(show_mines = true) }.to output(expected_output).to_stdout
      end

      it "reveals all cells that have already been cleared" do
        test_board.grid[0][0].mine = true
        test_board.grid[1][1].mine = true
        test_board.grid[2][2].mine = true
        test_board.clear(0, 1)
        test_board.clear(0, 2)
        test_board.clear(0, 0)

        renderer.board = test_board

        expected_output = /0 1 2 \n\nX 2 1 \t0\n. X . \t1\n. . X \t2\n/
        expect { renderer.draw_grid(show_mines = true) }.to output(expected_output).to_stdout
      end
    end

    describe "#show_flags_left" do
      let (:test_grid) { Array.new(3) { Array.new(3) { Cell.new } } }
      let (:test_board) { Board.new(test_grid) }

      it "displays the number of flags left at the start of the game" do
        renderer.board = test_board
        expect { renderer.show_flags_left }.to output(/Flags left: 9/).to_stdout
      end

      it "displays the correct number of flags after a flag has been used" do
        renderer.board = test_board
        renderer.board.flag(0, 0)

        expect { renderer.show_flags_left }.to output(/Flags left: 8/).to_stdout
      end

      it "displays the correct number of flags after a flag has been removed" do
        renderer.board = test_board
        renderer.board.flag(0, 0)
        renderer.board.unflag(0, 0)

        expect { renderer.show_flags_left }.to output(/Flags left: 9/).to_stdout
      end
    end
  end
end