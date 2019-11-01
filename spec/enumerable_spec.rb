# frozen_string_literal: true

require './enumerable.rb'

describe 'Enumerable' do
  let(:num_arr) { [3, 4, 2, 1] }
  let(:empty_arr) { [] }
  let(:word_arr) { %w[ant antelope dog zebra] }

  describe '#my_each' do
    context 'If block is given' do
      it 'iterates the given block for each array item' do
        my_array = []
        original_array = []
        num_arr.my_each { |i| my_array << i + 2 }
        num_arr.each { |i| original_array << i + 2 }
        expect(my_array).to eql(original_array)
      end
    end

    context 'If block is not given' do
      it 'returns an enumerator' do
        expect(num_arr.my_each.is_a?(Enumerable)).not_to be false
      end
    end
  end

  describe '#my_each_with_index' do
    context 'If block is given' do
      it 'iterates the given block for each array item using their indexes' do
        my_array = []
        original_array = []
        num_arr.my_each_with_index { |item, index| my_array << item + index }
        num_arr.each_with_index { |item, index| original_array << item + index }
        expect(my_array).to eql(original_array)
      end
    end

    context 'If block is not given' do
      it 'returns an enumerator' do
        expect(num_arr.my_each_with_index.is_a?(Enumerable)).not_to be false
      end
    end
  end

  describe '#my_select' do
    context 'If block is given' do
      it 'selects items that fulfil a condition given in the block' do
        my_array = num_arr.my_select { |item| item > 2 }
        original_array = num_arr.select { |item| item > 2 }
        expect(my_array).to eql(original_array)
      end
    end

    context 'If block is not given' do
      it 'returns an enumerator' do
        expect(num_arr.my_select.is_a?(Enumerable)).to be true
      end
    end
  end

  describe '#my_all?' do
    context 'If a class is given' do
      it 'returns true if all items in the array belong to that class' do
        my_result = word_arr.my_all? String
        original_result = word_arr.all? String
        expect(my_result).to eql(original_result)
      end
    end

    context 'If called without an argument or block' do
      it 'returns true' do
        expect(num_arr.my_all?).to be true
      end
    end
  end

  describe '#my_any?' do
    context 'If a class is given' do
      it 'returns true if any item in the array belongs to that class' do
        my_result = word_arr.my_any? Integer
        original_result = word_arr.any? Integer
        expect(my_result).to eql(original_result)
      end
    end

    context 'If called without an argument or block' do
      it 'returns true if any item is true' do
        expect(num_arr.my_any?).not_to be false
      end
    end
  end

  describe '#my_none?' do
    context 'If a block is given' do
      it 'returns true if no item in the array satisfies the condition stated in the block' do
        my_result = word_arr.my_none? { |item| item.length < 4 }
        original_result = word_arr.none? { |item| item.length < 4 }
        expect(my_result).to eql(original_result)
      end
    end

    context 'If called without an argument or block' do
      it 'returns false if any item is true' do
        expect(num_arr.my_none?).to be false
      end
    end
  end

  describe '#my_count' do
    context 'If a block is given' do
      it 'counts the number of items in the array that satisfy the condition stated in the block' do
        my_result = num_arr.my_count { |item| item < 5 }
        original_result = num_arr.count { |item| item < 5 }
        expect(my_result).to eql(original_result)
      end
    end

    context 'If a class is given as the argument' do
      it 'counts the number of array items that belong to that class' do
        expect(num_arr.count(String)).to eql(num_arr.my_count(String))
      end
    end
  end

  describe '#my_map' do
    context 'If block is given' do
      it 'returns a new array of items that fulfil the condition given in the block' do
        my_array = num_arr.my_map { |item| item > 0 }
        original_array = num_arr.map { |item| item > 0 }
        expect(my_array).to eql(original_array)
      end
    end

    context 'If block is not given' do
      it 'returns an enumerator' do
        expect(num_arr.my_map.is_a?(Enumerable)).to be true
      end
    end
  end

  describe '#my_inject' do
    context 'If a block is given' do
      it 'combines all elements using the binary operation specified in the block' do
        my_result = num_arr.my_inject { |sum, num| sum + num }
        original_result = num_arr.my_inject { |sum, num| sum + num }
        expect(my_result).to eql(original_result)
      end
    end

    context 'If a symbol alone or in combination with an initial value is given as an argument' do
      it 'combines all elements starting with the initial using the operator specified in the symbol' do
        my_result = num_arr.my_inject(1, :*)
        original_result = num_arr.my_inject(1, :*)
        expect(my_result).to eql(original_result)
      end
    end
  end
end
