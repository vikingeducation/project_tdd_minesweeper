class Square

  attr_accessor :proximity, :cleared

  def initialize(mine, cleared)
    @mine = mine          #boolean for existence of mine or is empty
    @cleared = cleared    #boolean for tracking cleared squares (by player)
    @proximity = 0        #integer for tracking mines in proximity
  end

  private_class_method :new

  #factory methods
  def self.build_mine
    new(true, false)
  end

  def self.build_empty
    new(false, false)
  end

  #setter method overrides
  def proximity=(adjacent_mines)
    raise ArgumentError, "Not an integer!" unless adjacent_mines.is_a?(Fixnum)
    raise ArgumentError, "Must be between 0-8" unless (0..8).to_a.include?(adjacent_mines)
    @proximity = adjacent_mines
  end

  def cleared=(status)
    raise ArgumentError, "Not a Boolean!" unless status == !!status
    @cleared = status
  end

  #returns true if mine exists in this square
  def has_mine?
    return @mine
  end
end
