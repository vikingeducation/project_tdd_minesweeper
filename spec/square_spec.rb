require 'square' 


describe Square do

 let(:square) { Square.new }

 describe '#initialize' do

  it "flagged is false" do
    expect(square.flagged).to be false
  end

  it "revealed is false" do
    expect(square.revealed).to be false
  end
 end

end