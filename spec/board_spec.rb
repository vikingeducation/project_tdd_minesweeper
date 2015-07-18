require "board"

describe Board do

  
  describe "#initialize" do
    
    it "starts with a blank grid by default" do
      blank_grid = { 
                    :a => [nil, nil, nil, nil, nil, nil, nil, nil, nil, nil], 
                    :b => [nil, nil, nil, nil, nil, nil, nil, nil, nil, nil], 
                    :c => [nil, nil, nil, nil, nil, nil, nil, nil, nil, nil], 
                    :d => [nil, nil, nil, nil, nil, nil, nil, nil, nil, nil], 
                    :e => [nil, nil, nil, nil, nil, nil, nil, nil, nil, nil], 
                    :f => [nil, nil, nil, nil, nil, nil, nil, nil, nil, nil], 
                    :g => [nil, nil, nil, nil, nil, nil, nil, nil, nil, nil], 
                    :h => [nil, nil, nil, nil, nil, nil, nil, nil, nil, nil], 
                    :i => [nil, nil, nil, nil, nil, nil, nil, nil, nil, nil], 
                    :j => [nil, nil, nil, nil, nil, nil, nil, nil, nil, nil]
                   }
      expect( subject.grid ).to eq(blank_grid)
      
    end

  end

end