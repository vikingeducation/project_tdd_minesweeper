require 'board'

describe Board do
  describe '#initialize' do
    it "sets up a board" do
      expect(subject.board.flatten.length).to eq(100)
    end
  end
end