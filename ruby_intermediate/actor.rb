# frozen_string_literal: true

class Actor
  def initialize(&block)
    @block = block
  end

  def queue
    @queue ||= Queue.new
  end

  def pop
    queue.pop
  end

  def push(value)
    queue.push(value)
  end

  def run
    Thread.new do
      loop do
        instance_eval(&@block)
      end
    end
  end

  def self.start(*list)
    threads = list.map(&:run)
    threads.each(&:join)
  end
end

output = Actor.new do
  puts "> Recived: #{pop}"
end

mid = Actor.new do
  message = pop
  output.push message.upcase
end

input = Actor.new do
  msg = gets
  mid.push msg
end

Actor.start(output, mid, input)
