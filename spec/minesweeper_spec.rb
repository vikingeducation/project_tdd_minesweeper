require "minesweeper"

describe Minesweeper do 

  let(:game){Minesweeper.new}


  describe "#initialize" do
    it "should create a new Player instance saved to an instance variable" do 
      expect(game.player).to be_an_instance_of(Player)
    end

    it "should create a new Board instance saved to an instance variable" do 
      expect(game.board).to be_an_instance_of(Board)
    end
  end

end