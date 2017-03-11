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
      expected_output = "...\n...\n...\n"
      expect { renderer.draw_grid }.to output(expected_output).to_stdout
    end

    it "shows a cleared cell's adjacent mine count if it has adjacent mines" do
      test_board.grid[0][0].mine = true
      test_board.grid[2][2].mine = true
      renderer.board = test_board

      renderer.board.grid[1][1].adjacent_mine_count = renderer.board.adjacent_mines(1, 1)

      renderer.board.grid[1][1].clear

      expected_output = "...\n.2.\n...\n"
      expect { renderer.draw_grid }.to output(expected_output).to_stdout
    end

    it "shows a cleared cell as a blank if it does not have adjacent mines" do
      renderer.board = test_board

      renderer.board.grid[1][1].adjacent_mine_count = renderer.board.adjacent_mines(1, 1)

      renderer.board.grid[1][1].clear

      expected_output = "...\n. .\n...\n"
      expect { renderer.draw_grid }.to output(expected_output).to_stdout
    end

    it "marks a flagged cell as flagged" do
      renderer.board = test_board

      renderer.board.grid[1][1].flag

      expected_output = "...\n.F.\n...\n"
      expect { renderer.draw_grid }.to output(expected_output).to_stdout
    end

    it "does not reveal existing mines" do
      test_board.grid[1][1].mine = true
      renderer.board = test_board

      expected_output = "...\n...\n...\n"
      expect { renderer.draw_grid }.to output(expected_output).to_stdout
    end
  end

  describe "#render_only_mines" do
    it "reveals all cells with mines"

    it "shows all cleared cells"
  end
end