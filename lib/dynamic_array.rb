require_relative "static_array"
require('byebug')

class DynamicArray
  attr_reader :length

  def initialize(capacity = 8)
    @store = StaticArray.new(capacity)
    @length = 0 #aka count
    @capacity = capacity
    @start_idx = 0
  end

  # O(1)
  def [](index)
    if index >= @length || @length == 0
      raise Exception.new("index out of bounds")
    end
    @store[index]
  end

  # O(1)
  def []=(index, value)
    if index > @length
      raise Exception.new("index out of bounds")
    end
    @store[index] = value
    @length += 1
  end

  # O(1)
  def pop
    raise Exception.new("index out of bounds") if @length == 0
    @length -= 1
    @store[@length]
  end

  # O(1) ammortized; O(n) worst case. Variable because of the possible
  # resize.
  def push(val)
    resize! if @length == @capacity
    @store[@length] = val
    @length += 1
  end

  # O(n): has to shift over all the elements.
  def shift
    raise Exception.new("index out of bounds") if @length == 0
    val = @store[0]
    @length.times {|idx| @store[idx] = @store[idx + 1]}
    @length -= 1
    val
  end

  # O(n): has to shift over all the elements.
  def unshift(val)
    resize! if @length == @capacity
    idx = @length
    while idx > 0
      @store[idx] = @store[idx - 1]
      idx -= 1
    end
    @store[0] = val
    @length += 1
  end

  protected
  attr_accessor :capacity, :store
  attr_writer :length

  def check_index(index)
    if index >= @length
      raise Exception.new("index out of bounds")
    end
  end

  # O(n): has to copy over all the elements to the new store.
  def resize!
    new_capacity = @capacity*2
    new_store = StaticArray.new(new_capacity)
    @length.times { |idx| new_store[idx] = @store[idx] }
    @start_idx = 0 # reset start_idx
    @capacity = new_capacity
    @store = new_store
  end
end
