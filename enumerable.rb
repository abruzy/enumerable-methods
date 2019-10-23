# frozen_string_literal: true

module Enumerable
  def my_each
    if block_given?
      (0..length - 1).my_each do |i|
        yield(self[i])
      end
    else
      puts "You didn't pass in a block!"
    end
  end

  def my_each_with_index
    if block_given?
      (0..length - 1).my_each do |i|
        yield(self[i], i)
      end
    else
      puts "You didn't pass in a block!"
    end
  end

  def my_select
    if block_given?
      new_arr = []
      (0..length - 1).my_each do |i|
        new_arr.push(self[i]) if yield(self[i])
      end
    else
      puts "You didn't pass in a block!"
    end
  end

  def my_all?
    (0..length - 1).my_each do |element|
      return false unless yield(element)
    end
    true
  end

  def my_any?
    (0..length - 1).my_each do |element|
      return false unless yield(element)
    end
    true
  end

  def my_none?
    i = 0
    while i < size
      return false if yield(self[i])

      i += 1
    end
    true
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

# Test Cases
# [1,2,3,4].my_each do |x|
#  puts x
# end

# [1, 2, 3, 4].my_each_with_index do |x, i|
#   puts "#{x}: #{i}"
# end

# even_numbers = []
# [1,2,3,4,5,6].my_select do |n|
#   if n.even?
#     even_numbers << n
#   end
# end
# even_numbers

# [].my_all? { |s| s.size == 1 }

# %w[ant bear cat].my_none? { |word| word.length >= 3 }
# %w[ant bear cat].all? { |word| word.length >= 4 }

# enu1 = [10, 19, 18]
# res1 = enu1.my_none? { |num| puts num > 15  }

# length = []
# length.my_count

# array = ["a", "b", "c"]
# array.my_map { |string| string.upcase }

# [3, 6, 10].my_inject {|sum, number| sum + number}

# def multiply_els(arr)
#   arr.my_inject {|x,y| x*y}
# end

# array = [2,4,5]
# multiply_els(array)

# double = Proc.new { |n| n * 2 }
# [1, 2, 3].my_map(&double)
