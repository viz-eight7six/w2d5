require 'byebug'

class Link
  attr_accessor :key, :val, :next, :prev

  def initialize(key = nil, val = nil)
    @key = key
    @val = val
    @next = nil
    @prev = nil
  end

  def to_s
    "#{@key}: #{@val}"
  end

  def remove
    # optional but useful, connects previous link to next link
    # and removes self from list.
    self.prev.next = @next
    self.next.prev = @prev
    @next = nil
    @prev = nil
    # @val = nil
    # @key = nil
  end
end

class LinkedList
  include Enumerable

  def initialize
    @head = Link.new
    @tail = Link.new
    @head.next = @tail
    @tail.prev = @head
  end

  def [](i)
    each_with_index { |link, j| return link if i == j }
    nil
  end

  def first
    @head.next
  end

  def last
    @tail.prev
  end

  def empty?
    @head.next == @tail
  end

  def get(key)
    itr_link = @head
    until itr_link == @tail
      return itr_link.val if itr_link.key == key
      itr_link = itr_link.next
    end
    nil
  end

  def include?(key)
    itr_link = @head
    until itr_link == @tail
      return true if itr_link.key == key
      itr_link = itr_link.next
    end
    false
  end

  def append(key, val)
    new_link = Link.new(key, val)
    new_link.next = @tail
    new_link.prev = @tail.prev
    @tail.prev.next = new_link
    @tail.prev = new_link
  end

  def update(key, val)
    itr_link = @head
    until itr_link == @tail
      itr_link.val = val if itr_link.key == key
      itr_link = itr_link.next
    end
    nil
  end

  def remove(key)
    itr_link = @head
    until itr_link == @tail
      if itr_link.key == key

        itr_link.remove
        break
      end
      itr_link = itr_link.next
    end
    nil
  end

  def each(&prc)
    itr_link = first
    until itr_link == @tail
      yield(itr_link)
      itr_link = itr_link.next
    end
  end

  # uncomment when you have `each` working and `Enumerable` included
  def to_s
    inject([]) { |acc, link| acc << "[#{link.key}, #{link.val}]" }.join(", ")
  end
end
