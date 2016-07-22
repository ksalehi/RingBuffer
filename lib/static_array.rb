# This class just dumbs down a regular Array to be staticly sized.
class StaticArray
  def initialize(length)
    @store = Array.new(length)
    @count = 0
  end

  # O(1)
  def [](index)
    # if index >= @count || @count == 0
    #   raise Exception.new("index out of bounds")
    # end
    @store[index]
  end

  # O(1)
  def []=(index, value)
    # if index > @count
    #   raise Exception.new("index out of bounds")
    # end
    @store[index] = value
    @count += 1
  end

  protected
  attr_accessor :store
end
