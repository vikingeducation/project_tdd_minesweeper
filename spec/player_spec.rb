# spec/player_spec.rb

require 'player'

describe Player do 

  let(:player){Player.new}
  describe "#initialize" do
    it "creates a player of type Player" do
      expect(Player.new).is_a? Player
    end
  end

  # describe "#ask_for_coordinates" do
  #   it "raises an error if the coordinates are in the incorrect format" do
  #     # expect(subject)
  #   end 
  # end

  describe "#validate_coordinates_formats" do
    it "displays an error message if coorindates are in wrong format" do
      expect(player.validate_coordinates_format("test")).to be("Your coordinates are in the improper format!")
    end

     it "returns true if coorindates are in the correct format" do
      expect(subject.validate_coordinates_format([0,2,])).to be true
    end
  end
end