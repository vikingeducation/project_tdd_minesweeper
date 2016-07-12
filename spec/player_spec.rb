require 'spec_helper'
require 'player'
require 'board'
require 'game'
require 'render'
require 'pry'


describe '.Player' do

	let( :player ) { Player.new }

	describe '#initialize' do

		it 'should be a Player' do

			expect( player ).to be_a( Player )

		end

	end


	describe '#get_move' do

		it 'should return player selection' do

			allow( player ).to receive( :gets ).and_return( "4" )

			expect( player.get_move ).to eq( 4 )

		end

	end

	describe '#get_coordinates' do

		it 'should get the coordinates fromt the player' do

			allow( player ).to receive( :gets ).and_return( "1,3" )

			expect( player.get_coordinates ).to eq( "1,3" )

		end


	end



end #/.Player