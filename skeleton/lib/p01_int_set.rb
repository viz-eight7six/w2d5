class MaxIntSet

  def initialize(max)
    @store = Array.new(max) {false}
  end

  def insert(num)
    @store[num] = true if is_valid?(num)
  end

  def remove(num)
    @store[num] = false
  end

  def include?(num)
    @store[num]
  end


  private

  def is_valid?(num)
    raise "Out of bounds" if num >= @store.length
    raise "Out of bounds" if num < 0

    true
  end

  def validate!(num)
  end
end


class IntSet
  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
  end

  def insert(num)
    self[num] << num unless self.include?(num)
  end

  def include?(num)
    self[num].any? { |el| num == el }
  end

  def remove(num)
    self[num].delete(num)
  end

  private

  def [](num)
    @store[num % 20]
  end
    # optional but useful; return the bucket corresponding to `num`

  def num_buckets
    @store.length
  end
end

class ResizingIntSet
  attr_reader :count
  attr_accessor :store

  def initialize(size = 20)
    @store = Array.new(size) { [] }
    @count = 0
  end


  def inspect
    p @store
  end

  def insert(num)
    if include?(num)
      false
    else
      self[num] << num
      @count += 1
      resize! if @count == num_buckets
      return true
    end
  end

  def remove(num)
    self[num].delete(num)
    @count -= 1
  end

  def include?(num)
    self[num].any? { |el| el == num }

  end
  private

  def [](num)
    @store[num % num_buckets]
  end


  def num_buckets
    @store.length
  end

  def resize!
    new_array = ResizingIntSet.new(num_buckets * 2)
    @store.each do |arr|
      arr.each do |el|
        new_array.insert(el)
      end
    end
    self.store = new_array.store
  end

end
