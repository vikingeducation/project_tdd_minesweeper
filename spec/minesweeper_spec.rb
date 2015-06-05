require 'minesweeper'
require 'pry'

describe Minesweeper do

  describe "#initialize" do

    it "creates a board with set height & width" do
      expect(Board).to receive(:new).with(10, 10, 9)
      Minesweeper.new
    end

    it "creates a player" do
      expect(Player).to receive(:new).with(10, 10)
      Minesweeper.new
    end

  end


  describe "#start" do
    let(:game) { Minesweeper.new }
    let(:board) { double(:place_mines => true, :render => true)}

    before do
      allow(Board).to receive(:new).and_return(board)
    end

    it "tells the board to place the mines" do
      allow(subject).to receive(:gameplay).and_return(false)
      expect(board).to receive(:place_mines)
      subject.start
    end

    it "sends a render call to the board" do
      allow(subject).to receive(:gameplay).and_return(false)
      expect(board).to receive(:render)
      subject.start
    end

    it "begins #gameplay" do
      expect(subject).to receive(:gameplay)
      subject.start
    end

  end


  describe "#gameplay" do
    let(:game) { Minesweeper.new }
    let(:board) { double(:process => ["clear","a","3"], :render => true) }
    let(:player) { double(:take_turn => ["clear","a","3"]) }

    before do
      allow(Board).to receive(:new).and_return(board)
      allow(Player).to receive(:new).and_return(player)
    end

    it "calls for player to take a turn" do
      expect(player).to receive(:take_turn)
      subject.gameplay
    end

    it "sends the move to the board for processing" do
      expect(board).to receive(:process)
      subject.gameplay
    end

  end

end