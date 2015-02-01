require 'toy_minefield'

describe ToyMinefield do

  let(:t){ ToyMinefield.new }

  it 'should default to a size-three board' do
    expect(t.size).to be 3
  end
  it 'should not have any mines' do
    expect(t.field.flatten.any? { |cell| cell.mine }).to be false
  end
  it '#generate_adjacent_mine_counts should be public' do
    expect do
      t.generate_adjacent_mine_counts
    end.not_to raise_error
  end
  it '#auto_clear should be public' do
    expect do
      t.auto_clear(0,0)
    end.not_to raise_error
  end
end