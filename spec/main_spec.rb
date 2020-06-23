require_relative '../main.rb'



describe Enumerable do
  let(:arr){[1,2,3,4]}
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
