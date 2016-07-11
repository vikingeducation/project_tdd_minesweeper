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

			expect( board.validate_move ).to be true

		end


	end


end #/.Board
