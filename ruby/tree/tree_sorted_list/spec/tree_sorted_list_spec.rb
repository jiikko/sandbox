require 'spec_helper'

describe TreeSortedList do
  describe '#generate' do
    context '素因数に重複がない時' do
      it '重複のない配列を返すこと' do
# 5, 2
#                    10
#          5                   15
#      3       7           13      17
        expect(TreeSortedList.new(10).generate).to eq [5, 3, 7, 15, 13, 17]
      end
    end

    context '素因数に重複がある時' do
      it '重複のない配列を返すこと' do
        skip
        expect(TreeSortedList.new(4).generate).to eq
      end
    end
  end
end
