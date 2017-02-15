# rspec/game_spec.rb
require 'game'
require 'board'

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

  describe "#process_clear_cell" do
    it "updates a spot that is clear as well as surrounding cells" do
      expect_any_instance_of(Game).to receive(:process_clear_cell)
      subject.process_clear_cell([0,0])
    end
  end

  describe "#process_flag" do
    it "processes the flag input" do
      expect_any_instance_of(Game).to receive(:process_flag)
      subject.process_flag([1,2])
    end
  end

   describe "#process_adj_mines" do
    it "processes the scenario where there are nearby mines to a cell" do
      expect_any_instance_of(Game).to receive(:process_adj_mines)
      subject.process_adj_mines([4,5], "1")
    end
  end

  describe "#final_user_output" do
    it "displays a message to the user if they have won" do
      allow_any_instance_of(Board).to receive(:full?).and_return true
      expect{subject.final_user_output}.to output(
        /You won! You conquered minesweeper!/).to_stdout
    end

    it "displays a message to the user if they have lost" do
      allow_any_instance_of(Board).to receive(:full?).and_return false
      subject.game_over = true
      expect{subject.final_user_output}.to output(
        /Sorry you lost! Try again next time!/).to_stdout
    end
  end

  describe "check when the game over" do
    it "returns true if the board is full" do
      allow_any_instance_of(Board).to receive(:full?).and_return true
      expect(subject.win?).to be true
    end

    it "returns false if the board is not full" do
      allow_any_instance_of(Board).to receive(:full?).and_return false
      expect(subject.win?).to be false
    end
  end
end
