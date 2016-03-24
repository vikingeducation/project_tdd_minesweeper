require "minesweepers"

describe Minesweepers do

  context "#initialize" do
    it "should be a Minesweepers" do
      game = Minesweepers.new
      expect(game).to be_a(Minesweepers)
    end

    it "accept a board of 10 by default" do
      expect(Board).to receive(:new).with(10, 9)
      Minesweepers.new(10)
    end

    it "accept a bigger size of board" do
      expect(Board).to receive(:new).with(20, 9)
      Minesweepers.new(20)
    end

    it "accept more bombs" do
      expect(Board).to receive(:new).with(10, 20)
      Minesweepers.new(10, 20)
    end

    it "accept a board with 9 bombs by default" do
      expect(Board).to receive(:new).with(10, 9)
      Minesweepers.new()
    end
  end

  context "#play" do
    before do
      allow_any_instance_of(Player).to receive(:get_input).and_return([1,1,"c"])
      allow_any_instance_of(Board).to receive(:game_over).and_return(false, true)
    end
    it "should call #instruction on start" do
      expect_any_instance_of(Minesweepers).to receive(:instruction)
      Minesweepers.new.play
    end

    it "should call #create_bombs to place the bombs" do
      expect_any_instance_of(Board).to receive(:create_bombs)
      Minesweepers.new.play
    end

    it "should call #create_bomb_indication to place the indication" do
      expect_any_instance_of(Board).to receive(:create_bomb_indication)
      Minesweepers.new.play
    end

  end
end