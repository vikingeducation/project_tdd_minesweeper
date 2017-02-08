# rspec/mine_spec.rb

require 'mine'

describe Mine do
   describe '#initialize' do
    it 'creates a Mine of type Mine' do
      expect(Mine.new).is_a? Board
    end
end