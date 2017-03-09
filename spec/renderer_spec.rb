# spec/renderer_spec.rb

require 'renderer'
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

  describe "#render" do
    it "shows a cleared cell's adjacent mine count if it has adjacent mines"

    it "shows a cleared cell as blank if it does not have adjacent mines"

    it "marks a flagged cell as flagged"

    it "marks an uncleared cell as uncleared"

    it "does not reveal existing mines"
  end

  describe "#render_only_mines" do
    it "reveals all cells with mines"

    it "shows all cleared cells"
  end
end