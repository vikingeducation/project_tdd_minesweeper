require 'colorize'

class Cell
  attr_accessor :mark, :data

  def initialize
    @mark = hide
  end
end