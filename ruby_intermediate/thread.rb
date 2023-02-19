# frozen_string_literal: true

require 'open-uri'

threads = []

[
  'https://google.pl',
  'https://github.com',
  'https://stackoverflow.com',
  'https://google.pl',
  'https://github.com',
  'https://stackoverflow.com'
].each do |url|
  t = Thread.new do
    puts URI.parse(url).open.length
  end
  threads << t
end


threads.each(&:join)
