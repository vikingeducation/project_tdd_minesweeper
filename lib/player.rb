class Player
  attr_reader :name

  def initialize(name)
    @name = name
  end

  def get_move
    print "Your move > "
    gets.chomp
  end
end