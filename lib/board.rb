class Board
  attr_reader :field
  def initialize
    @field = Array.new(10) { Array.new(10) { 0 }  }
    9.times do
      @field[rand(0..9)][rand(0..9)]="M"
    end
  end

  def mines

  end




end
