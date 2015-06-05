require 'player'

describe Player do

  describe "#initialize" do

  end


  describe "#take_turn" do

    it "should return parsed input if valid move entered" do
      allow(subject).to receive(:gets).and_return("clear a 3")
      expect(subject.take_turn).to eq(["clear","a","3"])
    end

  end


  describe "#get_input" do

  end


  describe "#parse_input" do
    let(:p) { Player.new }

    it "break string into array of 3" do
      expect(p.parse_input("clear a 3")).to eq(["clear","a","3"])
    end

    it "should handle unexpected capitalization" do
      expect(p.parse_input("CleAr A 3")).to eq(["clear","a","3"])
    end

  end


  describe "#valid_input?" do

    it "returns true for one valid command, row, and column" do
      array = ["clear","a","3"]
      expect(subject.valid_input?(array)).to be_truthy
    end

    it "handles duplicates as long as only one unique command, row, and column" do
      array = ["clear","a","3","a","clear","a","3"]
      expect(subject.valid_input?(array)).to be_truthy
    end

    it "returns false if no valid command" do
      array = ["explode","a","3"]
      expect(subject.valid_input?(array)).to be_falsey
    end

    it "returns false if multiple valid commands" do
      array = ["clear","a","flag","3"]
      expect(subject.valid_input?(array)).to be_falsey
    end

    it "returns false if no valid row" do
      array = ["clear","a"]
      expect(subject.valid_input?(array)).to be_falsey
    end

    it "returns false if multiple valid rows" do
      array = ["clear","a","2","3"]
      expect(subject.valid_input?(array)).to be_falsey
    end

    it "returns false if no valid column" do
      array = ["clear","3", "4"]
      expect(subject.valid_input?(array)).to be_falsey
    end

    it "returns false if multiple valid columns" do
      array = ["clear","a","2","b"]
      expect(subject.valid_input?(array)).to be_falsey
    end

  end


end