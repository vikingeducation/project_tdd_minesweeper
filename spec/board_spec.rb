require_relative "../lib/board.rb"

describe Board do

  describe "#initialize" do

    it "is an instance of board class" do

      expect(subject).to be_a(Board)

    end

    it "creates a board of height * width" do

      expect(subject.game_state.flatten.length).to eq(subject.height * subject.width)

    end

    it "generates the right amount of mines" do

      #expect(subject.generate_mines)

    end

  end

end