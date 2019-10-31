# frozen_string_literal: true

require './enumerable'
RSpec.describe Enumerable do
  let(:arr) { [1, 2, 3, 4, 5, 6] }
  let(:new_arr) { [] }

  describe '#my_each' do
    let(:new_arr_each) { [] }
    context 'If block is not given' do
      it 'Return enumerable object' do
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
end
