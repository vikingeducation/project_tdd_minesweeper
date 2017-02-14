# rspec/game_spec.rb
require 'game'

describe Game do

  describe "#initialize" do
    it "is a Game instance" do
      expect( subject ).to be_a( Game )
    end
  end

  describe "#play" do
    it "checks if the game starts with the play method" do
      expect_any_instance_of(Game).to receive(:play)
      subject.play
    end
  end

  describe "#check_game_over" do
    game = Game.new
    game.game_over = true
    it "retruns true if the game is over" do
      expect(game.check_game_over).to be true
    end
  end
  # it "displays an error message if coordindates count is less than 2" do
  #     expect{ player.validate_coordinates_format([1])}.to output("Your coordinates are in the improper format!\n").to_stdout
  #   end
  # end
end