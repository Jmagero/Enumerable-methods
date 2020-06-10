module Enumerable
  def my_each
    return enum_for unless block_given?

    my_arr = *self
    i = 0
    while i < my_arr.length
      yield my_arr[i]
      i += 1
    end
    self
  end

  def my_each_with_index
    return enum_for unless block_given?

    my_arr = *self
    i = 0
    while i < my_arr.length
      yield my_arr[i], i
      i += 1
    end
    self
  end

  def my_select
    return enum_for unless block_given?

    result = []
    my_each { |x| result << x if yield(x) }
    result
  end

  # rubocop: disable Style/CaseEquality:

  def my_all?(args = nil)
    my_each do |i|
      if block_given?
        return false unless yield(i)
      elsif args.nil?
        return false unless i
      else
        return false unless args === i
      end
    end
    true
  end

  def my_any?(args = nil)
    my_each do |x|
      if block_given?
        return true if yield(x)
      elsif args.nil?
        return true if x
      elsif args === x
        return true
      end
    end
    false
  end

  def my_none?(args = nil)
    my_each do |x|
      if block_given?
        return false if yield x
      elsif args.nil?
        return false if x
      elsif args === x
        my_each { |_x| return false }
      end
    end
    true
  end

  def my_count(args = nil)
    counter = 0
    my_each do |i|
      if block_given?
        counter += 1 if yield(i)
      elsif !args.nil?
        counter += 1 if i === args
      elsif i
        counter += 1
      end
    end
    counter
  end

  # rubocop: enable Style/CaseEquality:

  def my_map(proc = nil)
    return to_enum unless block_given?

    arr = []
    to_a.my_each { |x| arr << (!proc.nil? ? proc.call(x) : yield(x)) }
    arr
  end

  def my_inject(initial_arg = nil, symbol = nil)
    array = to_a
    n = array.length
    if initial_arg.nil?
      result = array[0]
      array[1..n - 1].my_each { |x| result = yield(result, x) }
    elsif block_given?
      result = initial_arg
      array.my_each { |x| result = yield(result, x) }
    elsif initial_arg && symbol
      result = initial_arg
      array.my_each { |x| result = result.send(symbol, x) }
    elsif initial_arg.is_a? Integer
      result = initial_arg
      array.my_each { |x| result += x }
    else
      result = array[0]
      array[1..n - 1].my_each { |x| result = result.send(initial_arg, x) }
    end
    result
  end
end

def multiply_els(arr)
  arr.my_inject { |product, x| product * x }
end
