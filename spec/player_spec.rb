require_relative '../lib/player.rb'
require 'minesweeper'

describe Player do

  let(:player){Player.new((0..100).to_a)}

  describe "#initialize" do

    it "creates a player" do
      expect(player).to be_a(Player)
    end

    specify "player selects difficulty level" do
      allow(player).to receive(:gets).and_return("b ")
      expect(["B", "I", "A"]).to include(player.level)
    end

  end

  describe "#select_move and #valid_move" do

    specify "player enters move" do
      allow(player).to receive(:gets).and_return("1,2")
      expect(player.select_move).to be_a(Array)
    end

    specify "player move is validiated" do
      # allow(player).to receive(:select_move).with(mock_gameboard).and_return([1,2])
      # allow(player).to receive(:gameboard).with([1,2]).and_return((0..100).to_a)
      # expect(player.validate).to be_truthy
      expect(player.validate?([1,2])).to be_truthy
    end

    specify "if player move is invalid, ask again" do
      allow(player).to receive(:gets).and_return("500,1","1,2")
      expect(player.select_move).to eq([1,2])
    end

    # specify "player move is converted to specific cell" do

    # end

  end

  # describe "#valid_move" do

  # end

end