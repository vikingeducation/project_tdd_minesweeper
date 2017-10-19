require 'game'

describe Game do 

  let(:game) { Game.new }

  describe "#intialize" do 
    it "intializes a new Board object" do 
      expect(game.board).to be_a(Board)
    end
  end
end