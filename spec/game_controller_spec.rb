require 'spec_helper'

describe GameController do
	let(:game_model) do
		instance_double('GameModel', 
			:win? => true,
			:lose? => false,
			:validation => instance_double('GameValidation',
				:error => 'This is an error'
			),
			:move => ''
		)
	end
	let(:router) do
		instance_double('Mousevc::Router', 
			:action => ''
		)
	end
	let(:view) do
		instance_double('Mousevc::View',
			:render => ''
		)
	end
	let(:game_controller) do
		GameController.new(
			:model => model,
			:view => view,
			:router => router
		)
	end

	before do
		allow(Input).to receive(:prompt)
		allow(Input).to receive(:data).and_return('')
	end

	describe '#play' do
		it 'renders the game view'
		it 'renders the instructions view'
		it 'sets the router action to select_move'
		it 'calls Input#prompt'
		it 'calls reset if the user wants to reset'
	end

	describe '#over' do
		it 'renders the game view'
		it 'renders the win view when model.win? is true'
		it 'renders the lose view when model.win? is false'
		it 'renders the reset view'
		it 'calls Input#prompt'
		it 'sets the router action to play'
	end

	describe '#select_move' do
		it 'calls special_inputs when the input is cheat or boom'
		it 'calls model#move and sends it the input data'
		it 'calls Input#notice= if model#move returns false'
		it 'sets the router action to play if player did not win or lose'
		it 'sets the router action to over if the player won or lost'
	end
end
