require 'player'

describe Player do

  describe "#initialize" do

  end


  describe "#take_turn" do
    #asks for input
    #break if input is legit

    #return input
  end


  describe "#get_input" do

    xit "should give user a prompt" do
      p = Player.new
      expect(p).to receive(:gets).and_return(true)
      p.get_input
    end

    it "should result in calling #validate"

  end


  describe "#parse_input" do
    let(:p) { Player.new }

    it "break string into array of 3" do
      expect(p.parse_input("clear a 3")).to eq(["clear","a","3"])
    end

    it "should handle unexpected capitalization" do
      expect(p.parse_input("CleAr A 3")).to eq(["clear","a","3"])
    end

    #it "declare invalid if array is not equal to 3" do
    #  expect(p.parse_input("clear a b 4")).to raise_error
    #end

  end


  describe "#find_command?" do
    let(:p) { Player.new }

    it "returns true if there is one valid command" do
      expect(p.find_command?(["clear","A","3"])).to be_truthy
    end


    it "returns false if no valid command" do
      expect(p.find_command?(["A","3"])).to be_falsey
    end


    it "returns false if multiple valid commands" do
      expect(p.find_command?(["clear","A","flag","3"])).to be_falsey
    end

  end


  describe "#find_row?" do
    let(:p) { Player.new }

    it "returns true if there is one valid row" do
      expect(p.find_row?(["clear","A","3"])).to be_truthy
    end


    it "returns false if no valid row" do
      expect(p.find_row?(["clear", "A"])).to be_falsey
    end


    it "returns false if multiple valid rows" do
      expect(p.find_row?(["clear","A","3", "1"])).to be_falsey
    end

  end


  describe "#find_column?" do
    let(:p) { Player.new }

    it "returns true if there is one valid column" do
      expect(p.find_column?(["clear","A","3"])).to be_truthy
    end


    it "returns false if no valid column" do
      expect(p.find_column?(["clear","3"])).to be_falsey
    end


    it "returns false if multiple valid columns" do
      expect(p.find_column?(["B", "clear","A","3"])).to be_falsey
    end

  end


end