class Turn

  attr_reader :action

  def initialize
    print "which row?\n > "
    @row = gets.chomp.to_i
    print "which column?\n > "
    @column = gets.chomp.to_i
    @action = "x"
    until action_is_valid?
      print "which action?\n > "
      @action = gets.chomp.upcase
      print "that is not a valid action" unless action_is_valid?
    end
  end

  def message
    { row: @row,
      column: @column,
      action: @action }
  end

  private

  def action_is_valid?
    valid_actions.include? action
  end

  def valid_actions
    ["A","C","F","U"]
  end
end