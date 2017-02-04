require_relative 'p02_hashing'
require_relative 'p04_linked_list'
require 'byebug'

class HashMap
  attr_reader :count

  include Enumerable

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { LinkedList.new }
    @count = 0
  end

  def include?(key)
    @store[bucket(key)].include?(key)
  end

  def set(key, val)
    if @store[bucket(key)].include?(key)
      @store[bucket(key)].update(key, val)
    else
      @store[bucket(key)].append(key, val)
      @count += 1
      resize! if @count == num_buckets
    end
  end

  def get(key)
    # hash the key to get array index
    # mod the result by num_buckets
    # each thru the list to find the key and return the value
    @store[bucket(key)].get(key)
  end

  def delete(key)
    if include?(key)
      @store[bucket(key)].remove(key)
      @count -= 1
    end
  end

  def each
    @store.each do |link_l|
      link_l.each do |link|
        yield(link.key, link.val)
      end
    end
  end



  # uncomment when you have Enumerable included
  # def to_s
  #   pairs = inject([]) do |strs, (k, v)|
  #     strs << "#{k.to_s} => #{v.to_s}"
  #   end
  #   "{\n" + pairs.join(",\n") + "\n}"
  # end

  alias_method :[], :get
  alias_method :[]=, :set

  private

  def num_buckets
    @store.length
  end

  def resize!
    old_array = @store
    @count = 0
    @store = Array.new(num_buckets * 2) { LinkedList.new }
    old_array.each do |link_list|
      link_list.each do |link|
        self.set(link.key, link.val)
      end
    end
  end

  def bucket(key)
    key.hash % num_buckets
    # optional but useful; return the bucket corresponding to `key`
  end
end
