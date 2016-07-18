require 'spec_helper'
require 'board'
require 'render'

describe '.Board' do

	let( :board ) { Board.new }

	describe '#initialize' do

		it 'board should be a Board' do

			expect( board ).to be_a( Board )

		end

		it 'should create a 10 x 10 array' do

			expect( board.board ).to eq( Array.new(10) { Array.new( 10 ) { 0 } } )

		end

		it 'should set @flags == 9' do

			expect( board.instance_variable_get( :@flags )).to eq( 9 )

		end


		it 'should set @mines == 9' do

			expect( board.instance_variable_get( :@mines )).to eq( 9 )

		end

	end #/.initialize




	describe "#place_mines" do

		it 'should populate the board with 9 mines' do


			board.place_mines

			arr = board.board

			count = 0
			arr.each do | x |

				x.each do | y |
				 count +=1 if y == '*'

				end

			end

			expect( count ).to eq( 9 )

		end

	end #/.place_mines


	describe '#validate_move' do


		it 'should return true if move is in proper coordinates' do

			expect( board.valid_coordinates?( [1, 4] ) ).to be true

		end


		it 'should return false if move is out of range of proper coordinates' do

			expect( board.valid_coordinates?( [11, 12] ) ).to be false

		end


		it 'should raise error if numeric passed in' do

			expect{ board.valid_coordinates?( 5 ) }.to raise_error( RuntimeError )

		end

	end


	describe '#place_flag' do

		placed_board = [
					[ 'F', "-", "-", "-", "-", "-", "-", "-", "-", "-" ],
					[ "-", "-", "-", "-", "-", "-", "-", "-", "-", "-" ],
					[ "-", "-", "-", "-", "-", "-", "-", "-", "-", "-" ],
					[ "-", "-", "-", "-", "-", "-", "-", "-", "-", "-" ],
					[ "-", "-", "-", "-", "-", "-", "-", "-", "-", "-" ],
					[ "-", "-", "-", "-", "-", "-", "-", "-", "-", "-" ],
					[ "-", "-", "-", "-", "-", "-", "-", "-", "-", "-" ],
					[ "-", "-", "-", "-", "-", "-", "-", "-", "-", "-" ],
					[ "-", "-", "-", "-", "-", "-", "-", "-", "-", "-" ],
					[ "-", "-", "-", "-", "-", "-", "-", "-", "-", "-" ]
					]

		it 'should place a flag at the coordinates provided' do

			board.place_flag

			expect( board.display_board ).to eq( placed_board )
		end

		it 'should return false if no flags left' do

			board.instance_variable_set( :@flags, 0 )

			expect( board.place_flag ).to be false

		end


		describe '#add_mine_counts' do

			it 'should add mine counts around placed mines' do

				board.instance_variable_set(:@board, [
					[   0,   0,   0,   0,   0,   0,   0,   0,   0,   0 ],
					[   0,   0,   0,   0,   0,   0,   0,   0,   0,   0 ],
					[   0,   0, "*",   0,   0,   0,   0,   0,   0,   0 ],
					[   0,   0,   0, "*",   0,   0,   0,   0,   0,   0 ],
					[   0,   0,   0,   0,   0,   0,   0,   0,   0,   0 ],
					[   0,   0,   0,   0,   0,   0,   0,   0,   0,   0 ],
					[   0,   0,   0,   0,   0,   0,   0,   0,   0,   0 ],
					[   0,   0,   0,   0,   0,   0,   0,   0,   0,   0 ],
					[   0,   0,   0,   0,   0,   0,   0,   0,   0,   0 ],
					[   0,   0,   0,   0,   0,   0,   0,   0,   0,   0 ]
					])

				board.populate_hints

				expect( board.board ).to eq( [
					[   0,   0,   0,   0,   0,   0,   0,   0,   0,   0 ],
					[   0,   1,   1,   1,   0,   0,   0,   0,   0,   0 ],
					[   0,   1, "*",   2,   1,   0,   0,   0,   0,   0 ],
					[   0,   1,   2, "*",   1,   0,   0,   0,   0,   0 ],
					[   0,   0,   1,   1,   1,   0,   0,   0,   0,   0 ],
					[   0,   0,   0,   0,   0,   0,   0,   0,   0,   0 ],
					[   0,   0,   0,   0,   0,   0,   0,   0,   0,   0 ],
					[   0,   0,   0,   0,   0,   0,   0,   0,   0,   0 ],
					[   0,   0,   0,   0,   0,   0,   0,   0,   0,   0 ],
					[   0,   0,   0,   0,   0,   0,   0,   0,   0,   0 ]
					] )

			end

		end

	end #/.add_mine_counts


	describe "#check for mine" do

		it 'be true if mine is at coords' do

				board.instance_variable_set(:@board, [
					[   0,   0,   0,   0,   0,   0,   0,   0,   0,   0 ],
					[   0,   1,   1,   1,   0,   0,   0,   0,   0,   0 ],
					[   0,   1, "*",   2,   1,   0,   0,   0,   0,   0 ],
					[   0,   1,   2, "*",   1,   0,   0,   0,   0,   0 ],
					[   0,   0,   1,   1,   1,   0,   0,   0,   0,   0 ],
					[   0,   0,   0,   0,   0,   0,   0,   0,   0,   0 ],
					[   0,   0,   0,   0,   0,   0,   0,   0,   0,   0 ],
					[   0,   0,   0,   0,   0,   0,   0,   0,   0,   0 ],
					[   0,   0,   0,   0,   0,   0,   0,   0,   0,   0 ],
					[   0,   0,   0,   0,   0,   0,   0,   0,   0,   0 ]
					] )

				board.instance_variable_set( :@row, 2 )
				board.instance_variable_set( :@col, 2 )

			expect( board.check_for_mine ).to be true

		end


	end


	describe '#square_has_mine_count' do

		it 'should return true if a mine count is there' do

				board.instance_variable_set(:@board, [
					[   0,   0,   0,   0,   0,   0,   0,   0,   0,   0 ],
					[   0,   1,   1,   1,   0,   0,   0,   0,   0,   0 ],
					[   0,   1, "*",   2,   1,   0,   0,   0,   0,   0 ],
					[   0,   1,   2, "*",   1,   0,   0,   0,   0,   0 ],
					[   0,   0,   1,   1,   1,   0,   0,   0,   0,   0 ],
					[   0,   0,   0,   0,   0,   0,   0,   0,   0,   0 ],
					[   0,   0,   0,   0,   0,   0,   0,   0,   0,   0 ],
					[   0,   0,   0,   0,   0,   0,   0,   0,   0,   0 ],
					[   0,   0,   0,   0,   0,   0,   0,   0,   0,   0 ],
					[   0,   0,   0,   0,   0,   0,   0,   0,   0,   0 ]
					] )

				board.instance_variable_set( :@row, 3 )
				board.instance_variable_set( :@col, 2 )

				expect( board.square_has_mine_count ).to be true



		end

	end #/. square has mine count


	describe '#reveal_square' do


		it 'should reveal the square if a mine count is beneath it' do
				board.instance_variable_set(:@board, [
					[   0,   0,   0,   0,   0,   0,   0,   0,   0,   0 ],
					[   0,   1,   1,   1,   0,   0,   0,   0,   0,   0 ],
					[   0,   1, "*",   2,   1,   0,   0,   0,   0,   0 ],
					[   0,   1,   2, "*",   1,   0,   0,   0,   0,   0 ],
					[   0,   0,   1,   1,   1,   0,   0,   0,   0,   0 ],
					[   0,   0,   0,   0,   0,   0,   0,   0,   0,   0 ],
					[   0,   0,   0,   0,   0,   0,   0,   0,   0,   0 ],
					[   0,   0,   0,   0,   0,   0,   0,   0,   0,   0 ],
					[   0,   0,   0,   0,   0,   0,   0,   0,   0,   0 ],
					[   0,   0,   0,   0,   0,   0,   0,   0,   0,   0 ]
					] )

				board.instance_variable_set( :@row, 3 )
				board.instance_variable_set( :@col, 2 )
				board.reveal_square

				expect( board.display_board ).to eq( [
					[ "-", "-", "-", "-", "-", "-", "-", "-", "-", "-" ],
					[ "-", "-", "-", "-", "-", "-", "-", "-", "-", "-" ],
					[ "-", "-", "-", "-", "-", "-", "-", "-", "-", "-" ],
					[ "-", "-",   2, "-", "-", "-", "-", "-", "-", "-" ],
					[ "-", "-", "-", "-", "-", "-", "-", "-", "-", "-" ],
					[ "-", "-", "-", "-", "-", "-", "-", "-", "-", "-" ],
					[ "-", "-", "-", "-", "-", "-", "-", "-", "-", "-" ],
					[ "-", "-", "-", "-", "-", "-", "-", "-", "-", "-" ],
					[ "-", "-", "-", "-", "-", "-", "-", "-", "-", "-" ],
					[ "-", "-", "-", "-", "-", "-", "-", "-", "-", "-" ]
					] )



		end

	end #/.reveal square


	describe '#auto_clear' do

		it 'if coords is empty, all surrounding 0s should be shown' do

				board.instance_variable_set(:@board, [
					[   0,   0,   0,   0,   0,   0,   0,   0,   0,   0 ],
					[   0,   1,   1,   1,   0,   0,   0,   0,   0,   0 ],
					[   1,   2, "*",   2,   1,   0,   0,   0,   0,   0 ],
					[ "*",   2,   2, "*",   1,   0,   0,   0,   0,   0 ],
					[   1,   1,   1,   1,   1,   0,   0,   0,   0,   0 ],
					[   0,   0,   1, "*",   1,   0,   0,   0,   0,   0 ],
					[   0,   0,   1,   1,   1,   0,   0,   0,   0,   0 ],
					[   0,   0,   0,   1,   1,   1,   0,   0,   0,   0 ],
					[   0,   0,   0,   1, "*",   1,   0,   0,   0,   0 ],
					[   0,   0,   0,   1,   1,   1,   0,   0,   0,   0 ]
					] )


				board.auto_clear( 8, 1 )

				expect( board.display_board ).to eq( [
					[ "-", "-", "-", "-", "-", "-", "-", "-", "-", "-" ],
					[ "-", "-", "-", "-", "-", "-", "-", "-", "-", "-" ],
					[ "-", "-", "-", "-", "-", "-", "-", "-", "-", "-" ],
					[ "-", "-", "-", "-", "-", "-", "-", "-", "-", "-" ],
					[   1,   1,   1, "-", "-", "-", "-", "-", "-", "-" ],
					[   0,   0,   1, "-", "-", "-", "-", "-", "-", "-" ],
					[   0,   0,   1,   1, "-", "-", "-", "-", "-", "-" ],
					[   0,   0,   0,   1, "-", "-", "-", "-", "-", "-" ],
					[   0,   0,   0,   1, "-", "-", "-", "-", "-", "-" ],
					[   0,   0,   0,   1, "-", "-", "-", "-", "-", "-" ]
					] )

		end

	end #/.auto-clear


	describe '#generate_victory_board' do

		it 'should create a winning board with F in place of mines' do

				board.instance_variable_set(:@board, [
					[   0,   0,   0,   0,   0,   0,   0,   0,   0,   0 ],
					[   0,   1,   1,   1,   0,   0,   0,   0,   0,   0 ],
					[   1,   2, "*",   2,   1,   0,   0,   0,   0,   0 ],
					[ "*",   2,   2, "*",   1,   0,   0,   0,   0,   0 ],
					[   1,   1,   1,   1,   1,   0,   0,   0,   0,   0 ],
					[   0,   0,   1, "*",   1,   0,   0,   0,   0,   0 ],
					[   0,   0,   1,   1,   1,   0,   0,   0,   0,   0 ],
					[   0,   0,   0,   1,   1,   1,   0,   0,   0,   0 ],
					[   0,   0,   0,   1, "*",   1,   0,   0,   0,   0 ],
					[   0,   0,   0,   1,   1,   1,   0,   0,   0,   0 ]
					] )

					board.generate_victory_board

					expect( board.instance_variable_get(:@victory_board) ).to eq( [
					[   0,   0,   0,   0,   0,   0,   0,   0,   0,   0 ],
					[   0,   1,   1,   1,   0,   0,   0,   0,   0,   0 ],
					[   1,   2, "F",   2,   1,   0,   0,   0,   0,   0 ],
					[ "F",   2,   2, "F",   1,   0,   0,   0,   0,   0 ],
					[   1,   1,   1,   1,   1,   0,   0,   0,   0,   0 ],
					[   0,   0,   1, "F",   1,   0,   0,   0,   0,   0 ],
					[   0,   0,   1,   1,   1,   0,   0,   0,   0,   0 ],
					[   0,   0,   0,   1,   1,   1,   0,   0,   0,   0 ],
					[   0,   0,   0,   1, "F",   1,   0,   0,   0,   0 ],
					[   0,   0,   0,   1,   1,   1,   0,   0,   0,   0 ]
					] )

		end

	end

	describe '#Check_victory' do

		it 'returns true when boards match' do

			board.instance_variable_set( :@display_board, [
					[   0,   0,   0,   0,   0,   0,   0,   0,   0,   0 ],
					[   0,   1,   1,   1,   0,   0,   0,   0,   0,   0 ],
					[   0,   1, "F",   2,   1,   0,   0,   0,   0,   0 ],
					[   0,   1,   2, "F",   1,   0,   0,   0,   0,   0 ],
					[   0,   0,   1,   1,   1,   0,   0,   0,   0,   0 ],
					[   0,   0,   0,   0,   0,   0,   0,   0,   0,   0 ],
					[   0,   0,   0,   0,   0,   0,   0,   0,   0,   0 ],
					[   0,   0,   0,   0,   0,   0,   0,   0,   0,   0 ],
					[   0,   0,   0,   0,   0,   0,   0,   0,   0,   0 ],
					[   0,   0,   0,   0,   0,   0,   0,   0,   0,   0 ]
					] )

			board.instance_variable_set( :@victory_board, [
					[   0,   0,   0,   0,   0,   0,   0,   0,   0,   0 ],
					[   0,   1,   1,   1,   0,   0,   0,   0,   0,   0 ],
					[   0,   1, "F",   2,   1,   0,   0,   0,   0,   0 ],
					[   0,   1,   2, "F",   1,   0,   0,   0,   0,   0 ],
					[   0,   0,   1,   1,   1,   0,   0,   0,   0,   0 ],
					[   0,   0,   0,   0,   0,   0,   0,   0,   0,   0 ],
					[   0,   0,   0,   0,   0,   0,   0,   0,   0,   0 ],
					[   0,   0,   0,   0,   0,   0,   0,   0,   0,   0 ],
					[   0,   0,   0,   0,   0,   0,   0,   0,   0,   0 ],
					[   0,   0,   0,   0,   0,   0,   0,   0,   0,   0 ]
					] )

			expect( board.check_victory).to be true

		end


	end #/check victory

end #/.Board
