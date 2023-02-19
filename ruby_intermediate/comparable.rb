# frozen_string_literal: true

class Vector
  include Comparable
  def initialize(first_object, second_object)
    @first_object = first_object
    @second_object = second_object
  end

  def length
    Math.sqrt(@first_object * @first_object + @second_object * @second_object)
  end

  def <=>(other)
    length <=> other.length
  end
end

arr = [Vector.new(1, 2), Vector.new(1, 1), Vector.new(0, 1), Vector.new(5, 4)]
puts arr.inspect
puts arr.sort.inspect
