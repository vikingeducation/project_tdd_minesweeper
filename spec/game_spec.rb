require 'spec_helper'
require 'game'
require 'player'
require 'board'
require 'render'
require 'pry'


describe '.Game' do

	let( :game ) { Game.new }

	describe '#initialize' do

		it 'game should create an instance of Board' do

			expect( game.instance_variable_get( :@board ) ).to be_a( Board )

		end

		it 'game should create an instance of Player' do

			expect( game.instance_variable_get( :@player ) ).to be_a( Player )

		end


		it 'game should create an instance of Render' do

			expect( game.instance_variable_get( :@render ) ).to be_a( Render )

		end

	end


end #/.Game