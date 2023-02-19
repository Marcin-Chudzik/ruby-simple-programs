# frozen_string_literal: true

require 'eventmachine'
require 'em-http'

module SimpleServer
  def receive_data(data)
    puts data
    send_data("simpleserver: #{data}")
  end
end

module Server
  def receive_data(data)
    puts data
    send_data("server: #{data}")
  end
end


EM.run do
  EM.add_periodic_timer(1) { $stderr.write 'tick...' }
  EM.start_server 'localhost', 6666, SimpleServer
  EM.start_server 'localhost', 6665, Server
end
