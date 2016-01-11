class Square

  attr_accessor :proximity, :cleared

  def initialize(mine, cleared)
    @mine = mine          #boolean for existence of mine
    @cleared = cleared    #boolean for tracking cleared squares
    @proximity = 0        #integer for tracking mine count in proximity
  end

  private_class_method :new

  #factory methods
  def self.build_mine
    new(true, false)
  end

  def self.build_empty
    new(false, false)
  end

  def proximity=(adjacent_mines)
    raise ArgumentError, "Not an integer!" unless adjacent_mines.is_a?(Fixnum)
    raise ArgumentError, "Must be between 1-8" unless (1..8).to_a.include?(adjacent_mines)
    @proximity = adjacent_mines
  end

  def cleared=(status)
    raise ArgumentError, "Not a Boolean!" unless status == !!status
    @cleared = status
  end

  def has_mine?
    return @mine
  end
end
