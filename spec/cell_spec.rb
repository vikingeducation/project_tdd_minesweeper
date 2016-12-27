require "cell"

describe Cell do

	let(:cell) {Cell.new}

	describe '#initialize' do

		it 'sets the initial cell attributes properly' do
			expect(cell.state).to eq(:closed)
			expect(cell.content).to eq(:empty)
		end

	end

	describe '#render' do

		it 'can render on closed state' do
			cell.render
		end

		it 'can render on flagged state' do
			cell.state = :flagged
			cell.render
		end

		it 'can render on opened state when 3 mines around' do
			cell.state = :opened
			cell.content = 3.to_s.to_sym
			cell.render
		end

		it 'can render on opened state when empty' do
			cell.state = :opened
			cell.render
		end

		it 'can render on opened state when mine' do
			cell.state = :opened
			cell.content = :mine
			cell.render
		end
	end

end