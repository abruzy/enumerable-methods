# frozen_string_literal: true

module Enumerable
  def my_each
    return to_enum(:my_each) unless block_given?

    i = 0
    while i < size
      yield(self[i])
      i += 1
    end
    self
  end

  def my_each_with_index
    return to_enum(:my_each_with_index) unless block_given?

    i = 0
    while i < size
      yield(self[i], i)
      i += 1
    end
    self
  end

  def my_select
    return to_enum(:my_select) unless block_given?

    new_arr = []
    my_each { |element| new_arr << element if yield(element) }
    new_arr
  end

  def my_all?(pattern = nil)
    return my_all? { |e| pattern.match(e) } unless pattern.nil?

    return my_all? { |e| e } unless block_given?

    my_each { |e| return false unless yield(e) }
    true
  end

  def my_any?(pattern = nil)
    return my_any? { |e| pattern.match(e) } unless pattern.nil?

    return my_any? { |e| e } unless block_given?

    my_each { |e| return true if yield(e) }
    false
  end

  def my_none?(*pattern)
    return !my_any?(*pattern) unless block_given?

    !my_any? { |e| yield(e) }
  end

  def my_count
    i = 0
    count = []
    if block_given?
      while i < size
        count << self[i] if yield(self[i])
        i += 1
      end
      return count.size
    end
    size
  end

  def my_map(&block)
    arr = []
    my_each do |e|
      arr << block.call(e)
    end
    arr
  end

  def my_inject(initial = nil)
    result = initial.nil? ? self[0] : initial
    (1..length - 1).each do |i|
      result = yield(result, self[i])
    end
    result
  end
end

def multiply_els(arr)
  arr.my_inject { |x, y| x * y }
end
