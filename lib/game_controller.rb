class GameController < Mousevc::Controller
	def play
		@view.render('game',
			:game => @model
		)
		@view.render('instructions')
		@router.action = :select_move
		Input.prompt
		reset if Input.reset?
	end

	def over
		@view.render('game', :game => @model)
		view = @model.win? ? 'win' : 'lose'
		@view.render(view)
		@view.render('reset')
		Input.prompt
		@router.action = :play
	end

	def select_move
		if ['cheat', 'boom'].include?(Input.data)
			special_inputs
		else
			Input.notice = @model.validation.error unless @model.move(Input.data)
		end
		if @model.win? || @model.lose?
			@router.action = :over
		else
			@router.action = :play
		end
		special_inputs
	end

	private
		def reset
			Input.clear
			Persistence.clear(:GameController)
			@router.action = :play
		end

		def special_inputs
			@model.cheat if Input.data == 'cheat'
			@model.boom if Input.data == 'boom'
		end
end