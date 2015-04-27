require "benchmark"
require "celluloid/autostart"

class MyWorker
  include Celluloid

  def do_lengthy_operation(id)
    sleep 2 
    puts "worked on id: #{id}"
  end
end

pool = MyWorker.pool(size: 20)

time = Benchmark.measure do
  futures = []
  (1..100).each {|i| futures << pool.future.do_lengthy_operation(i)}
  futures.map(&:value)
end

puts time

