# frozen_string_literal: true

require 'observer'

class Stock
  include Observable
  attr_reader :symbol
  attr_accessor :quote

  def initialize(symbol)
    @symbol = symbol
  end

  def quote=(new_price)
    @quote = new_price
    changed
    notify_observers(self, new_price)
  end
end

class LowNotifier
  def initialize(limit)
    @limit = limit
  end

  def update(stock, new_price)
    return unless new_price < @limit

    puts "New price of #{stock.symbol}: #{new_price}. Buy now!"
  end
end

class HighNotifier
  def initialize(limit)
    @limit = limit
  end

  def update(stock, new_price)
    return unless new_price > @limit

    puts "New price of #{stock.symbol}: #{new_price}. Sell now!"
  end
end


t = Stock.new('WIG20')
t.add_observer(LowNotifier.new(90))
t.add_observer(HighNotifier.new(110))
t.quote = 100
t.quote = 95
t.quote = 105
t.quote = 70
t.quote = 120
