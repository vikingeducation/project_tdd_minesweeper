require 'square' 


describe Square do

 let(:square) { Square.new("unmarked") }

 describe '#initialize' do

  it "take parameter 'mark'" do
    expect(square.mark).to eq("unmarked")
  end

  it "status is nil" do
    expect(square.status).to be nil
  end

  it "status can be set" do
    square.status = "bomb"
    expect(square.status).to eq("bomb")
  end




 end

end