# frozen_string_literal: true

require 'concurrent'
require 'open-uri'

# l1 = Concurrent::Future.execute { URI.open("https://google.pl").length }
# l2 = Concurrent::Future.execute { URI.open("https://github.com").length }

# puts l1.value + l2.value

module Enumerable
  def pmap(&block)
    futures = map { |e| Concurrent::Future.execute { block.call(e) } }
    futures.map(&:value)
  end
end

array = [
  'https://google.pl',
  'https://github.com',
  'https://stackoverflow.com',
  'https://google.pl',
  'https://github.com',
  'https://stackoverflow.com'
]

puts array.pmap { |url| URI.parse(url).open.length }.reduce(&:+)
