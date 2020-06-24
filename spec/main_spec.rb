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
      expect(arr.my_each{|x| x}).to eql([1,2,3,4])
    end
  end

  describe 'my_each_with_index' do
    it 'Should return enumerator' do
      expect(arr.my_each_with_index).to be_an Enumerator
    end
  
    it 'Should accept a block' do
      index = []
      arr.my_each_with_index{|x, i| index << i}
      expect(index).to eql([0,1,2,3])
    end
  end
  
  describe 'my_select' do
    it 'Should accept a block' do
      expect(arr.my_select{|x| x>2}).to eql([3,4])
    end
  end

  describe 'my_all?' do
    it 'Should accept a block' do
      expect(arr.my_all?{|x| x > 2}).to eql(false)
    end

    regex = %w[dog door rod blade]
    it 'Should accept a Regex' do
      expect(regex.my_all?(/d/)).to eql(true)
    end

    it 'Should check for nil' do
      expect(arr.my_all?).to eql(true)
    end

  end

end

