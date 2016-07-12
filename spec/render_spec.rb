require 'spec_helper'
require 'render'
require 'board'

describe '.Render' do

	let( :render ) { Render.new }

	describe '#render_board' do

		it 'should receieve render method' do

			expect( render ).to receive( :render_board )

			render.render_board( 5 )

		end

	end #/.render_board

	describe '#render_flags' do

		it 'should receive render_flags' do

			expect( render ).to receive( :render_flags )

			render.render_flags( 5 )

		end

	end #/.render_flags



	describe '#render_message' do

		it 'should receive render_message' do

			expect( Render ).to receive( :render_message )

			Render.render_message( "hello" )

		end

	end #/.render_message

end #/.Render