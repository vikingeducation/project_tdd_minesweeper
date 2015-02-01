require 'turn'

describe Turn do
  # let(:t) { Turn.new }
  it 'returns a hash' do
    expect(Turn.new).to be_a_kind_of Hash
  end
  it 'has key \'row\''
  it 'turn[row] is an integer'
  it 'has key \'column\''
  it 'turn[column] is an integer'
  it 'has key \'action\''
  it 'turn[action] is an allowed letter'
end