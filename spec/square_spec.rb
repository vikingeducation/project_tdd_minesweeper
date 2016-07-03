require_relative '../lib/square.rb'
describe Square do
  describe "#initialize" do
    it "returns a Squares" do
      expect(subject).to be_a(Square)
    end
  end
end