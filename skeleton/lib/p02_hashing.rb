class Fixnum
  # Fixnum#hash already implemented for you
end

class Array
  def hash
    sum = 0
    self.each_with_index do |el, i|
      el = el.hash if el.is_a?(Array)
      sum += el.ord * i
    end
    sum.hash
  end
end

class String
  def hash
    self.split('').hash
  end
end

class Hash
  # This returns 0 because rspec will break if it returns nil
  # Make sure to implement an actual Hash#hash method
  def hash
    self.map(&:to_s).to_a.sort.hash
  end
end
