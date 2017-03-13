# spec/game_spec.rb

describe "Game" do
  describe "#initialize" do
    it "creates an instance of Game"

    it "creates an instance of Player in the game"

    it "creates an instance of Board in the game"

    it "creates an instance of Renderer in the game"
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