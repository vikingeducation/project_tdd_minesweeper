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

  context "at the start of the game" do
    it "shows game instructions to the player"

    it "shows the initial minefield"

    it "shows the number of flags left"
  end

  context "during every turn" do
    it "asks the player what action he'd like to take"

    it "asks the player for coordinates, if required for the action"

    it "updates the game board, if necessary"

    it "updates the number of flags left, if necessary"

    it "shows the current state of the minefield"

    it "shows the number of flags left"
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