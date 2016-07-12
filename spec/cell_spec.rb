require 'cell'

describe Cell do

  describe '#initialize' do
    it "calls #determine_state" do
      expect(subject).to receive(:determine_state)
      Cell.new([0,1],"board")
    end
  end

end
