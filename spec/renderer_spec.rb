# spec/renderer_spec.rb

describe "Renderer" do
  describe "#initialize" do
    it "creates a Renderer"

    it "sets the game board it's rendering to nil"

    it "accepts an optional parameter as the game board it will render"
  end

  describe "#render" do
    it "prints the current state of the game board to screen"
  end

  describe "#only_mines" do
    it "prints all Cells that are mines"

    it "also prints all Cells that have already been cleared"
  end

  describe "#instructions" do
    it "prints the game instructions to the player"
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