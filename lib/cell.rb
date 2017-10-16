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

  def to_s
    if visible && flag
      "#{Icon::FLAG}"
    elsif visible
      "#{value} "
    else
      "#{Icon::HIDDEN}"
    end
  end

end #Cell

class Mine < Cell
  def to_s
    visible ? "#{Icon::MINE}" : "#{Icon::HIDDEN}"
  end
end