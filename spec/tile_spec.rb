require './lib/tile'
require 'spec_helper'

describe Tile do

  let(:tile) { described_class.new }
  let(:nine) { described_class.new(3, 3, 1) }

  describe '#intialize' do
    it 'sets x variables' do
      expect(nine.x).to eq(3)
    end

    it 'has a mine when set' do
      expect(nine.mine).to eq(1)
    end

    it 'has not yet been revealed' do
      expect(nine.revealed).to be_falsey
    end

  end

  describe '#click' do
    before do
      nine.click
    end

    it 'sets revealed to true' do
      expect(nine.revealed).to eq(true)
    end
  end

end
