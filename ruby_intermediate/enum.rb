# frozen_string_literal: true

class Colors
  include Enumerable

  def each
    yield 'red'
    yield 'green'
    yield 'blue'
    yield 'yellow'
    yield 'white'
    yield 'black'
  end
end

puts Colors.new.map(&:upcase)
puts Colors.new.reverse_each.select { |e| e.length > 4 }.map(&:reverse)
