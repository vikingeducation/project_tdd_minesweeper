require 'spec_helper'

describe GameController do
	let(:model) do
		instance_double('GameModel',
			:validation => instance_double('GameValidation',
				:error => 'This is an error'
			),
			:move => ''
		)
	end
	let(:router) do
		instance_double('Mousevc::Router', 
			:action= => ''
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
		before do
			allow(router).to receive(:action=).with(:select_move)
		end

		it 'renders the game view' do
			expect(view).to receive(:render).with('game', :game => model)
			game_controller.play
		end

		it 'renders the instructions view' do
			expect(view).to receive(:render).with('instructions')
			game_controller.play
		end

		it 'sets the router action to select_move' do
			expect(router).to receive(:action=).with(:select_move)
			game_controller.play
		end

		it 'calls Input#prompt' do
			expect(Input).to receive(:prompt)
			game_controller.play
		end

		it 'calls reset if the user wants to reset' do
			allow(Input).to receive(:reset?).and_return(true)
			expect(game_controller).to receive(:reset)
			game_controller.play
		end
	end

	describe '#over' do
		before do
			allow(model).to receive(:win?)
			allow(model).to receive(:lose?)
		end

		it 'renders the game view' do
			expect(view).to receive(:render).with('game', :game => model)
			game_controller.over
		end

		it 'renders the win view when model.win? is true' do
			expect(view).to receive(:render).with('win')
			allow(model).to receive(:win?).and_return(true)
			allow(model).to receive(:lose?).and_return(false)
			game_controller.over
		end

		it 'renders the lose view when model.win? is false' do
			expect(view).to receive(:render).with('lose')
			allow(model).to receive(:win?).and_return(false)
			allow(model).to receive(:lose?).and_return(true)
			game_controller.over
		end

		it 'renders the reset view' do
			expect(view).to receive(:render).with('reset')
			game_controller.over
		end

		it 'calls Input#prompt' do
			expect(Input).to receive(:prompt)
			game_controller.over
		end

		it 'sets the router action to play' do
			expect(router).to receive(:action=).with(:play)
			game_controller.over
		end
	end

	# 
	# 

	describe '#select_move' do
		before do
			allow(Input).to receive(:data)
			allow(Input).to receive(:notice)
			allow(model).to receive(:win?)
			allow(model).to receive(:lose?)
		end

		it 'calls special_inputs when the input is cheat' do
			expect(game_controller).to receive(:special_inputs)
			allow(Input).to receive(:data).and_return('cheat')
			game_controller.select_move
		end

		it 'calls special_inputs when the input is boom' do
			expect(game_controller).to receive(:special_inputs)
			allow(Input).to receive(:data).and_return('boom')
			game_controller.select_move
		end

		it 'calls special_inputs when the input is flag' do
			expect(game_controller).to receive(:special_inputs)
			allow(Input).to receive(:data).and_return('flag')
			game_controller.select_move
		end

		it 'calls model#move and sends it the input data' do
			expect(model).to receive(:move).with('I say I\'m dead, and I move...')
			allow(Input).to receive(:data).and_return('I say I\'m dead, and I move...')
			game_controller.select_move
		end

		it 'calls Input#notice= if model#move returns false' do
			expect(Input).to receive(:notice=).with('You dun broked it!')
			allow(model).to receive(:move).and_return(false)
			allow(model.validation).to receive(:error).and_return('You dun broked it!')
			game_controller.select_move
		end

		it 'sets the router action to play if player did not win or lose' do
			expect(router).to receive(:action=).with(:play)
			game_controller.select_move
		end

		it 'sets the router action to over if the player won or lost' do
			expect(router).to receive(:action=).with(:over)
			allow(model).to receive(:win?).and_return(true)
			game_controller.select_move
		end
	end
end


