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
end