class Cell
  attr_accessor :revealed, :flagged, :is_mine, :adj_mine_count

  def initialize(is_mine)
    @is_mine = is_mine
    @adj_mine_count = 0
    @revealed = false
    @flagged = false
  end

  def color
    case render_sym
    when :M
      return :blue
    when :X
      return :green
    when :F
      return :cyan
    when :S
      return :white
    when 1.to_s.to_sym, 2.to_s.to_sym, 3.to_s.to_sym, 4.to_s.to_sym, 5.to_s.to_sym, 6.to_s.to_sym, 7.to_s.to_sym, 8.to_s.to_sym
      return :yellow
    else
      return :default
    end
  end

  def render_sym
    if @flagged
      return :F
    elsif !@revealed
      return :S
    else
      return value_sym
    end
  end

  def value_sym
    if @is_mine
      return :M
    elsif @adj_mine_count == 0
      return :X
    else
      return @adj_mine_count.to_s.to_sym
    end
  end
end # Cell
