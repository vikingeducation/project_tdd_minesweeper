require 'game'

describe Game do 

  let(:game) { Game.new }

  describe "#intialize" do 
    it "intializes a new Board object" do 
      expect(game.board).to be_a(Board)
    end
  end

  describe "#make_move" do 
    it "takes in a string from STDIN" do
      allow(game).to receive(:gets).and_return('1, 2, 3') 
      expect(game).to receive(:gets)
      game.make_move
    end

    it "raises an error if the received string contains fewer than two commas" do 
      allow(game).to receive(:gets).and_return('')
      expect{ game.make_move }.to raise_error
    end

    it "returns an array" do 
      allow(game).to receive(:gets).and_return('1,2,3')
      expect(game.make_move).to be_an(Array)
    end 

    it "raises error if the returned array contains fewer than three elements" do 
      allow(game).to receive(:gets).and_return('1, 2')
      expect{game.make_move}.to raise_error
    end
  end
end