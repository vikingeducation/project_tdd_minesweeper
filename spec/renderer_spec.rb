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

  describe "#welcome" do
    it "prints a welcome message" do
      expect { renderer.welcome }.to output(/Welcome to Minesweeper/).to_stdout
    end
  end

  describe "#prompt_action" do
    it "prints a prompt with instructions to the player for his desired action" do
      expect { renderer.prompt_action }.to output("Do you want to (c)lear, (f)lag, (u)nflag a cell; or (r)eset / (q)uit?\n").to_stdout
    end
  end

  describe "#invalid_coords" do
    it "prints a message indicating the specified coordinates are invalid"
  end

  describe "#no_flags_left" do
    it "prints a message indicating that there are no flags left"
  end

  describe "#reset" do
    it "prints a message indicating the game has reset"
  end

  describe "#game_over" do
    it "prints a message indicating the game is over"
  end

  describe "#display_exit" do
    it "prints an exit message"
  end
end