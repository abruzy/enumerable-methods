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

  def my_all?(classification = nil)
    test = true
    checked = classification.class
    my_each { |item| return false if yield(item) == false } if block_given?
    my_each { |item| return false unless item.class == classification } if checked == Class
    my_each { |item| return false unless item =~ classification } if checked == Regexp
    my_each { |item| return false unless item == classification } if [Integer, String].include?(checked)
    my_each { |item| return false unless item } if !classification && !block_given?
    test
  end

  def my_any?(classification = nil)
    test = false
    my_each { |item| return true if yield(item) == true } if block_given?
    my_each { |item| return true if item.class == classification } if classification.class == Class
    my_each { |item| return true if item =~ classification } if classification.class == Regexp
    my_each { |item| return true if item == classification } if [Integer, String].include?(classification.class)
    my_each { |item| return true if item } if !classification && !block_given?
    test
  end

  def my_none?(classification = nil)
    test = true
    my_each { |item| return false if yield(item) == true } if block_given?
    my_each { |item| return false if item.class == classification } if classification.class == Class
    my_each { |item| return false if item =~ classification } if classification.class == Regexp
    my_each { |item| return false if item == classification } if [Integer, String].include?(classification.class)
    my_each { |item| return false if item } if !classification && !block_given?
    test
  end

  def my_count(classification = nil)
    counter = 0
    my_each { |item| counter += 1 if item == classification } if [Integer, String].include?(classification.class)
    my_each { |item| counter += 1 if yield(item) == true } if block_given?
    my_each { |item| counter += 1 if item.class == classification } if classification.class == Class
    return length if !classification && !block_given?

    counter
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

  def my_inject(total = nil, current = nil)
    arr = is_a?(Range) ? to_a : self
    beginner = total.nil? || total.is_a?(Symbol) ? arr[0] : total
    if block_given?
      start = total ? 0 : 1
      arr[start..-1].my_each { |item| beginner = yield(beginner, item) }
    end
    arr[1..-1].my_each { |item| beginner = beginner.send(total, item) } if total.is_a?(Symbol)
    arr[0..-1].my_each { |item| beginner = beginner.send(current, item) } if current
    beginner
  end
end
