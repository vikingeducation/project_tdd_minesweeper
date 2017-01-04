require_relative 'render'

class Cell 
  attr_accessor :display, :status, :mine
  attr_reader :position

  def initialize(position)
    @display = Render::EMPTY_CELL
    @status = 'uncleared' 
    @mine = false
    @position = position
  end

  def update_cell!(action, adjacent_mines_value)
    case action
    when 'c'
      @status = 'cleared'
      if adjacent_mines_value.nil?
        @display = Render::BOMB_RB 
      elsif  adjacent_mines_value == 0
        @display = Render::CLEARED_CELL 
      else
        @display = Render.cleared_cell(adjacent_mines_value)
      end
    when 'f'
      @status = 'flagged'
      @display = Render::FLAG
    when 'u'
      @status = 'uncleared'
      @display = Render::EMPTY_CELL
    end
  end
end