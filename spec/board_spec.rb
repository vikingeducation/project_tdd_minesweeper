require 'spec_helper'
require 'board'
require 'render'

describe '.Board' do

	let( :board ) { Board.new }
	let( :render ) { instance_double( "Render" ) }

	describe '#initialize' do

		it 'board should be a Board' do

			expect( board ).to be_a( Board )

		end

		it 'should create a 10 x 10 array' do

			expect( board.instance_variable_get( :@board )).to eq( Array.new(10) { Array.new( 10 )})

		end

		it 'should set @flags == 9' do

			expect( board.instance_variable_get( :@flags )).to eq( 9 )

		end


		it 'should set @mines == 9' do

			expect( board.instance_variable_get( :@mines )).to eq( 9 )

		end

	end #/.initialize




	describe "#place_mines" do

		it 'should populate the board with 10 mines' do

			array = board.place_mines

			count = 0
			array.each do | x |

				x.each do | y |
				 count +=1 if y == 'M'

				end

			end

			expect( count ).to eq( 10 )

		end

	end #/.place_mines


	describe '#validate_move' do


		it 'should return true if move is in proper coordinates' do

			expect( board.valid_coordinates?( "1, 4" ) ).to be true

		end


		it 'should return false if move is out of range of proper coordinates' do

			expect( board.valid_coordinates?( "11, 12" ) ).to be false

		end


		it 'should raise error if numeric passed in' do

			expect{ board.valid_coordinates?( 5 ) }.to raise_error( RuntimeError )

		end

	end


	describe '#place_flag' do

		placed_board = [
					[ 'F', nil, nil, nil, nil, nil, nil, nil, nil, nil ],
					[ nil, nil, nil, nil, nil, nil, nil, nil, nil, nil ],
					[ nil, nil, nil, nil, nil, nil, nil, nil, nil, nil ],
					[ nil, nil, nil, nil, nil, nil, nil, nil, nil, nil ],
					[ nil, nil, nil, nil, nil, nil, nil, nil, nil, nil ],
					[ nil, nil, nil, nil, nil, nil, nil, nil, nil, nil ],
					[ nil, nil, nil, nil, nil, nil, nil, nil, nil, nil ],
					[ nil, nil, nil, nil, nil, nil, nil, nil, nil, nil ],
					[ nil, nil, nil, nil, nil, nil, nil, nil, nil, nil ],
					[ nil, nil, nil, nil, nil, nil, nil, nil, nil, nil ]
					]

		it 'should place a flag at the coordinates provided' do

			board.place_flag( "0, 0" )

			expect( board.instance_variable_get( :@board ) ).to eq(placed_board )

		end

		it 'should return false if no flags left' do

			board.instance_variable_set( :@flags, 0 )

			expect( board.place_flag( "1, 2" ) ).to be false

		end

	end

end #/.Board
