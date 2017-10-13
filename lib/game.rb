require_relative 'instructions'

class Game

  include Instructions

  def play
    render_welcome
    render_instructions
  end

end

