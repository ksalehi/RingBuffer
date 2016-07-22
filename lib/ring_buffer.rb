require_relative "static_array"

class RingBuffer
  attr_reader :length

  def initialize(capacity = 8)
    @capacity = capacity
    @store = StaticArray.new(capacity)
    @length = 0
    @start_idx = 0
  end

  # O(1)
  def [](index)
    if index >= @length || @length == 0
      raise Exception.new("index out of bounds")
    end
    @store[check_index(index)]
  end

  # O(1)
  def []=(index, val)
    if index > @length
      raise Exception.new("index out of bounds")
    end
    @store[check_index(index)] = val
  end

  # O(1)
  def pop
    raise Exception.new("index out of bounds") if @length == 0
    @length -= 1
    @store[check_index(@length)]
  end

  # O(1) ammortized
  def push(val)
    resize! if @length == @capacity
    @store[check_index(@length)] = val
    @length += 1
  end

  # O(1)
  def shift
    raise Exception.new("index out of bounds") if @length == 0
    val = self[0]
    @start_idx = (@start_idx + 1) % capacity #shift start_idx by 1
    @length -= 1
    val
  end

  # O(1) ammortized
  def unshift(val)
    resize! if @length == @capacity
    idx = check_index(-1)
    @store[idx] = val
    @start_idx = idx
    @length += 1
  end

  protected
  attr_accessor :capacity, :start_idx, :store
  attr_writer :length

  def check_index(index)
    (@start_idx + index) % @capacity
  end

  def resize!
    new_capacity = @capacity*2
    new_store = StaticArray.new(new_capacity)
    @length.times { |idx| new_store[idx] = @store[check_index(idx)] }
    @start_idx = 0 # reset start_idx
    @capacity = new_capacity
    @store = new_store
  end
end
