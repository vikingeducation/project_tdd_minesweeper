require 'cell'

describe Cell do

  context "#initialize" do

    it "starts out hidden" do
      expect( subject.covered? ).to be true
    end
    
  end
  
end