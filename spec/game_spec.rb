require './lib/game'
require 'spec_helper'

describe Game do

  let(:game) { described_class.new(4, 4, 5) }
  let(:ded) { described_class.new(2, 2, 5) }

  describe '#intialize' do
    it 'fails to intialize when too many bombs are entered' do
      expect{ ded }.to raise_error(RuntimeError)
    end
  end

  describe '#click' do
    it 'returns information about the game ending'

    it 'tells the user the tile had no bomb and has been revealed'
  end

end
