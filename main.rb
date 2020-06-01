
module Enumerable
  def my_each
    return enum_for unless  block_given?
    my_arr = *self
    i = 0 
    while i < my_arr.length
      yield my_arr[i]
      i+=1
    end
  end

  def my_each_with_index 
    return enum_for unless block_given?
      my_arr = *self
      i = 0 
      while i < my_arr.length
      yield my_arr[i],i
      i+=1
      end
  end

  def my_select
    return enum_for unless block_given?
    result = []
    self.my_each{ |x| result << x if yield(x)}
    result
  end

  def my_all?
    return enum_for unless block_given?
    self.my_select { |x|return false if  yield(x) === false}
    true   
  end
end

{"name" => "Celyn", "car" => "green"}.my_each{|elem| puts elem}
