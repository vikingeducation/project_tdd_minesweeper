require 'spec_helper'

describe Minesweeper do
	let(:minesweeper){Minesweeper.new}

	describe '#initialize' do
		it 'returns a new instance of the minesweeper class' do
			expect(minesweeper).to be_an_instance_of(Minesweeper)
		end
	end
end