require 'thread'

class Sixpool
  def initialize(size=6)
    @size = size
    @jobs = Queue.new
    @pool = Array.new(@size) do |i|
     Thread.new do
       Thread.current[:id] = i
       catch(:exit) do
         loop do
            job, args = @jobs.pop
            job.call(*args)
          end
        end
      end
    end
  end
  
  def attack(*args, &block)
    @jobs << [block, args]
  end
  
  def gg
    @size.times do
      attack { throw :exit }
    end
    @pool.map(&:join)
  end
end
