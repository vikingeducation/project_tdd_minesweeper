require_relative 'icon'

class Cell
  include Icon

  attr_accessor :value, :visible

  def initialize
    @value = 0
    @visible = false
  end

  def self.count_visible
    results = ObjectSpace.each_object(self).find_all do |object|
       object.instance_variable_get(:@visible) == true
    end
    results.length
  end

  def to_s
    visible ? "#{value} " : "#{Icon::HIDDEN}"
  end

  def flag
    "#{Icon::FLAG}"
  end
end

class Mine < Cell
  def to_s
    visible ? "#{Icon::MINE}" : "#{Icon::HIDDEN}"

  end
end