# spec/player_spec.rb

require 'player'

describe Player do 

  let(:player){Player.new}
  describe "#initialize" do
    it "creates a player of type Player" do
      expect(Player.new).is_a? Player
    end
  end

  describe "#validate_coordinates_formats" do
    it "displays an error message if coordindates count is more than 2" do
      expect{subject.validate_coordinates_format([6,9,0])}.to output("Your coordinates are in the improper format!\n").to_stdout
    end

    it "displays an error message if coordindates count is less than 2" do
      expect{ player.validate_coordinates_format([1])}.to output("Your coordinates are in the improper format!\n").to_stdout
    end

    it "returns true if coordinates are in the correct format" do
      expect(subject.validate_coordinates_format([0,2])).to be true
    end

     it "returns false if not an array" do
      expect(player.validate_coordinates_format("1,2")).to be(nil)
    end
  end

  describe "#ask_for_flag" do
    it "prints directions to screen to ask for a flag" do
    #   # first stub out `gets` and pass it a value so that it doesn't hang waiting for input
      allow(player).to receive(:gets).and_return("Y")
      expect{player.ask_for_flag}.to output(
        /Do you want to flag this cell as marked with a mine?.*/).to_stdout
    end

    it "returns a flag of true if the user has chosen to flag a cell" do
      allow(player).to receive(:gets).and_return("Y")
      expect(player.ask_for_flag).to be true
    end
  end

  describe "#ask_for_coordinates" do
    it "prints directions to screen" do
      allow(player).to receive(:gets).and_return("\n")
      expect{player.ask_for_coordinates}.to output(
        /Enter your coordinates.*/).to_stdout
    end

    it "returns array of coordinates" do
      allow(player).to receive(:gets).and_return("3,2")
      expect(player.ask_for_coordinates).to eq([3,2])
    end

   

  end



end