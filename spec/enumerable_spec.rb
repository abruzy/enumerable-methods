# frozen_string_literal: true

require './enumerable'
RSpec.describe Enumerable do
  let(:arr) { [1, 2, 3, 4, 5, 6] }
  let(:new_arr) { [] }

  describe '#my_each' do
    let(:new_arr_each) { [] }
    context 'If block is not given' do
      it 'return enumerable object' do
        expect(new_arr_each.my_each.is_a?(Enumerable)).to eql(true)
      end
    end

    context 'If block is given' do
      it 'iterates through array of elements' do
        my_array = []
        original_array = []
        arr.my_each { |i| my_array << i * 2 }
        arr.each { |i| original_array << i * 2 }
        expect(my_array).to eql(original_array)
      end
    end
  end

  describe '#my_each_with_index' do
    context 'If block is not given' do
      it 'returns an enumerable object' do
        expect(arr.my_each_with_index.is_a?(Enumerable)).to eql(true)
      end
    end

    context 'If block is given' do
      it 'returns the item and its index for each item in enum' do
        %w[cat dog wombat].my_each_with_index { |_item, index| new_arr << index }
        expect(new_arr).to eql([0, 1, 2])
      end
    end
  end

  describe '#my_select' do
    context 'If block is not given' do
      it 'returns an enumerable object' do
        expect(arr.my_select.is_a?(Enumerable)).to eql(true)
      end
    end

    context 'If block is given' do
      it 'returns an array containing all elements of enum for which the given block returns a true value' do
        expect(arr.my_select(&:even?)).to eql([2, 4, 6])
      end
    end
  end
end
