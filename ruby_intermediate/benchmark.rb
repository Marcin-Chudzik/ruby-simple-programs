# frozen_string_literal: true

require 'benchmark'

arr = (1..100).to_a
m = 50_000
n = 200_000

Benchmark.bmbm do |x|
  x.report('block') { m.times { arr.map { |e| e.to_s } } }
  x.report('proc') { m.times { arr.map(&:to_s) } }
end

Benchmark.bmbm do |x|
  x.report('reverse_each') { n.times { arr.reverse_each { |e| e } } }
  x.report('reverse.each') { n.times { arr.reverse.each { |e| e } } }
end
