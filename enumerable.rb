# frozen_string_literal: true

module Enumerable
  def my_each
    return to_enum(:my_each) unless block_given?

    arr = is_a?(Enumerable) && !is_a?(Array) ? to_a : self

    i = 0
    while i < size
      yield(arr[i])
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

  def my_all?(*arg)
    return grep(arg.first).length == size unless arg.empty?

    my_each { |el| return false unless yield(el) } if block_given?

    my_each { |el| return false unless el } unless block_given?

    true
  end

  def my_any?(*arg)
    return !grep(arg.first).empty? unless arg.empty?

    my_each { |el| return true if yield(el) } if block_given?

    my_each { |el| return true if el } unless block_given?

    false
  end

  def my_none?(*arg)
    return grep(arg.first).empty? unless arg.empty?

    my_each { |el| return false if yield(el) } if block_given?

    my_each { |el| return false if el } unless block_given?

    true
  end

  def my_count(*arg)
    return my_select { |el| el == arg.first }.length unless arg.empty?

    return my_select { |el| yield el }.length if block_given?

    size
  end

  def my_map(&my_proc)
    return to_enum(:my_map) unless block_given?

    i = 0
    result = []
    while i < length
      answer = my_proc.call(self[i])
      result << answer
      i += 1
    end
    result
  end

  def my_inject(arg = nil)
    res = [Integer, Float].include?(arg.class) ? arg : first
    arr = to_a

    if block_given?
      if arg && [Integer, Float].include?(arg.class)
        my_each { |el| res = yield(res, el) }
      else
        arr[1..-1].my_each { |el| res = yield(res, el) }
      end
    end
    arr[1..-1].my_each { |el| res = res.send(arg, el) } if arg.is_a? Symbol

    res
  end
end
