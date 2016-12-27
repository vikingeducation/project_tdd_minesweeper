require "board"

describe Board do

	let(:board) {Board.new}
	let(:small_board) {Board.new(3,3)}
	let(:a_cell) {double("Cell", render: 0, is_mine: false)}
	let(:a_mine_cell) {double("Cell", render: 0, is_mine: true)}
	let(:array_to_test) {[[a_cell, a_cell, a_cell],[a_cell, a_mine_cell, a_mine_cell],[a_mine_cell, a_cell, a_cell]]}

	#  0 0 0
	#  0 1 1
	#  1 0 0

	describe '#initialize' do

		it 'properly initializes the board params' do

		end

	end

	describe '#map' do

		it 'generates a 10x10 board' do
			board.generate_map
			expect(board.mine_count).to be_within(1).of(10)
		end

		it 'calculates adjucent mines properly1' do 
			small_board.instance_variable_set(:@board_array, array_to_test)
			mines = small_board.get_adjucent_mines(1,1)
			expect(mines).to eq(2)
		end

		it 'calculates adjucent mines properly2' do 
			small_board.instance_variable_set(:@board_array, array_to_test)
			mines = small_board.get_adjucent_mines(0,0)
			expect(mines).to eq(1)
		end

		it 'calculates adjucent mines properly3' do 
			small_board.instance_variable_set(:@board_array, array_to_test)
			mines = small_board.get_adjucent_mines(2,1)
			expect(mines).to eq(3)
		end

	end
	

end