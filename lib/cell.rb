require_relative 'icon'

class Cell
  include Icon

  attr_accessor :value, :visible, :flag

  def initialize
    @value = 0
    @visible = false
    @flag = false
  end

  def self.count_visible
    results = ObjectSpace.each_object(self).find_all do |object|
       object.instance_variable_get(:@visible) == true
    end
    results.length
  end

  def self.count_flags
    results = ObjectSpace.each_object(self).find_all do |object|
       object.instance_variable_get(:@flag) == true
    end
    results.length
  end

  def to_s
    if visible
      "#{value} "
    elsif flag
      "#{Icon::FLAG}"
    else
      "#{Icon::HIDDEN}"
    end
  end

  def reveal
    self.visible = true
  end

  def place_flag
    self.flag = true
  end

  def losing_choice?
    is_a?(Mine)
  end

end #Cell

class Mine < Cell
  def to_s
    visible ? "#{Icon::MINE}" : "#{Icon::HIDDEN}"
    # "#{Icon::MINE}"
  end
end