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
    it "prints the current state of the game board to screen"
  end

  describe "#only_mines" do
    it "prints all Cells that are mines"

    it "also prints all Cells that have already been cleared"
  end
end