class MaxIntSet
  def initialize(max)
    @store = Array.new(max) {false}
  end

  def insert(num)
    raise "too big" if num > @store.length
    @store[num] = true
  end

  def remove(num)
    @store[num] = false
  end

  def include?(num)
    @store[num]
  end
end

require 'byebug'

class IntSet

  def initialize
    @store = Array.new(20) { [] }
  end

  def insert(num)
    self[num] << num unless self.include?(num)
  end

  def include?(num)
    self[num].any? { |el| num == el }
  end

  def [](num)
    @store[num % 20]
  end

  def remove(num)
    self[num].delete(num)
  end

end

class ResizingIntSet

  attr_accessor :store

  def initialize(size)
    @store = Array.new(size) { [] }
    @size = size
    @el_count = 0
  end

  def resize
    new_array = ResizingIntSet.new(@size * 2)
    @store.each do |arr|
      arr.each do |el|
        new_array.insert(el)
      end
    end
    self.store = new_array.store
    @size *= 2
  end

  def inspect
    p @store
  end

  def insert(num)
    unless include?(num)
      self[num] << num unless include?(num)
      @el_count += 1
    end
    resize if @el_count == @size
    num
  end

  def remove(num)
    self[num].delete(num)
    @el_count -= 1
  end

  def include?(num)
    self[num].any? { |el| el == num }
  end

  def [](num)
    @store[num % @size]
  end
end
