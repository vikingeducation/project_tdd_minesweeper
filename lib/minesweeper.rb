require 'mousevc'

require_relative 'game_controller.rb'
require_relative 'game_model.rb'

include Mousevc

class Minesweeper < Mousevc::App
	def initialize
		super(
			:controller => 'GameController',
			:model => 'GameModel',
			:views => "#{File.dirname(__FILE__)}/views",
			:action => :play,
			:looping => true,
			:system_clear => true
		)
	end
end

Minesweeper.new.run