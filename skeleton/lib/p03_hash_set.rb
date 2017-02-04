require_relative 'p02_hashing'

class HashSet
  attr_reader :count

  attr_accessor :store

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(key)
    if include?(key)
      return false
    else
      self[key] << key
      @count += 1
      resize! if @count == num_buckets
    end
  end

  def include?(key)
    self[key].include?(key)
  end

  def remove(key)
    if include?(key)
      self[key].delete(key)
      @count -= 1
    end
  end

  private

  def [](key)
    # optional but useful; return the bucket corresponding to `num`
    @store[key.hash % num_buckets]
  end

  def num_buckets
    @store.length
  end

  def resize!
    new_array = HashSet.new(num_buckets * 2)
    @store.each do |arr|
      arr.each do |el|
        new_array.insert(el)
      end
    end
    self.store = new_array.store
  end
end
