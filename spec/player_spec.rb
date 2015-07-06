require_relative '../lib/player.rb'
require 'minesweeper'

describe Player do

  let(:player){Player.new}

  describe "#initialize" do

    it "creates a player" do
      expect(player).to be_a(Player)
    end

    specify "player selects difficulty level" do
      allow(player).to receive(:gets).and_return("b ")
      expect(["B", "I", "A"]).to include(player.level)
    end

  end

  describe "#select_move" do

  end

  describe "#valid_move" do

  end

end