require_relative '../main.rb'

describe Enumerable do
  let(:arr) { [1, 2, 3, 4] }
  let(:hash) { { a: 'a', b: 'b', c: 'c' } }
  let(:range) { (1..5) }
  let(:wordarray) { %w[dog door rod blade] }
  let(:mixedarray) { [1, nil, 'test', []] }
  let(:falsyarray) { [nil, false, nil] }

  describe '#my_each' do
    it 'Should return enumerator' do
      expect(arr.my_each).to be_an Enumerator
    end

    it 'Should accept a block' do
      expect(arr.my_each { |x| x }).to eql([1, 2, 3, 4])
    end

    it 'Should work on ranges' do
      expect(range.my_each { |x| x }).to eql(range)
    end

    it 'Should work on hashes' do
      expect(hash.my_each {}).to eql(hash)
    end
  end

  describe 'my_each_with_index' do
    it 'Should return enumerator' do
      expect(arr.my_each_with_index).to be_an Enumerator
    end

    it 'Should accept a block' do
      index = []
      arr.my_each_with_index { |_, i| index << i }
      expect(index).to eql([0, 1, 2, 3])
    end

    it 'Should work on ranges' do
      expect(range.my_each { |x| x }).to eql(range)
    end

    it 'Should work on hashes' do
      expect(hash.my_each {}).to eql(hash)
    end
  end

  describe 'my_select' do
    it 'Should accept a block' do
      expect(arr.my_select { |x| x > 2 }).to eql([3, 4])
    end
  end

  describe 'my_all?' do
    it 'Should accept a block' do
      expect(arr.my_all? { |x| x > 2 }).to eql(false)
    end

    it 'Should accept a Regex' do
      expect(wordarray.my_all?(/d/)).to eql(true)
    end

    it 'Should accept a class as the first argument' do
      expect(wordarray.my_all?(String)).to eql(true)
    end

    it 'Should work without a block and return true when all values are truthy' do
      expect(arr.my_all?).to eql(true)
    end

    it 'Should return false if the block returns false for one of the values at least' do
      expect(arr.my_all? { |x| x > 3 }).to eql(false)
    end

    it 'Should return true if the block returns true for all the values' do
      expect(arr.my_all? { |x| x > 0 }).to eql(true)
    end
  end

  describe 'my_any?' do
    it 'Should accept a block' do
      expect(arr.my_any? { |x| x > 2 }).to eql(true)
    end

    it 'Should accept a Regex' do
      expect(wordarray.my_any?(/oo/)).to eql(true)
    end

    it 'Should accept a class as the first argument' do
      expect(mixedarray.my_any?(Numeric)).to eql(true)
    end

    it 'Should work without a block and check for at least one truthy value' do
      expect(mixedarray.my_any?).to eql(true)
    end

    it 'Should return false if the block returns false for all of the values' do
      expect(arr.my_any? { |x| x > 10 }).to eql(false)
    end

    it 'Should return true if the block returns true for at least one of the values' do
      expect(arr.my_any? { |x| x == 2 }).to eql(true)
    end
  end

  describe 'my_none?' do
    it 'Should accept a block' do
      expect(arr.my_none? { |x| x > 3 }).to eql(false)
    end

    it 'Should accept a Regex' do
      expect(wordarray.my_none?(/fajskdfjlasdfl/)).to eql(true)
    end

    it 'Should accept a class as the first argument' do
      expect(mixedarray.my_none?(Numeric)).to eql(false)
    end

    it 'Should work without a block and check if all the values are falsy' do
      expect(falsyarray.my_none?).to eql(true)
    end

    it 'Should return true if the block returns false for all the values' do
      expect(arr.my_none? { |x| x > 10 }).to eql(true)
    end

    it 'Should return false if the block returns true for at least one of the values' do
      expect(arr.my_none? { |x| x == 3 }).to eql(false)
    end
  end

  describe 'my_count' do
    it 'Should accept a block' do
      expect(arr.my_count{|x| x ==3}).to eql(1)
    end
    it 'Should return count of the truthy values in the list when block is not provided' do
      expect(arr.my_count).to eql(4)
    end
    it 'Should return count of the elements that match the given argument' do
      expect(arr.my_count(3)).to eql(1)
    end
  end
  describe 'my_map' do
    it 'Should return enumerator if no block' do
      expect(arr.my_map).to be_an Enumerator
    end
    it 'Should return a new array by running the block on the old one' do
      expect(arr.my_map{|x| x * 2}).to eql([2,4,6,8])
    end
  end
  describe 'my_inject' do
    it 'Should accept symbols' do
      expect(range.my_inject(:+)).to eql(15)
    end
    it 'Should accept a block' do
      expect(range.my_inject{|sum, n| sum + n}).to eql(15)
    end
    it 'Should accept initial value as first argument' do
      expect(range.my_inject(1,:*)).to eql(120)
    end
  end
end

