class Cell
  attr_accessor :mined_neighbors

  def initialize
    @covered = true
    @flagged = false
    @mined = false
    @mined_neighbors = 0
  end

  def covered?
    @covered
  end

  def flagged?
    @flagged
  end

  def mined?
    @mined    
  end

  def reveal!
    @covered = false    
  end

  def flag!
    @flagged = @flagged ? false : true   
  end

  def mine!
    @mined = true    
  end
 
end