
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

  def my_all?(pattern = nil)
    my_each do |x|
      if block_given?
        return false unless yield x
      elsif pattern.class == Regexp
        return false unless pattern =~ x
      elsif pattern.class == Class
        return false unless x.class == pattern
      elsif !pattern.nil?
        return false unless x == pattern
      else
        return false unless x
      end
    end
    true
  end

  def my_any?(pattern = nil)
    return false if (self - [nil, false]) == []
    my_each do |x|
      if block_given?
        return true if yield x
      elsif pattern.class == Regexp
        return true if pattern =~ x
      elsif pattern.class == Class
        return true if x.class == pattern
      elsif !pattern.nil?
        return true if x == pattern
      else
        return true unless x
      end
    end
    return true if pattern.nil? && !block_given?

    false
  end
end

