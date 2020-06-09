# rubocop: disable Style/CaseEquality:
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
        return true if x === args
      elsif x
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

  def my_map(proc = nil)
    return to_enum unless block_given?

    arr = []
    to_a.my_each { |x| arr << (!proc.nil? ? proc.call(x) : yield(x)) }
    arr
  end

  # rubocop: disable Metrics/PerceivedComplexity, Metrics/CyclomaticComplexity

  def my_inject(start = nil, arg = nil)
    arr = self
    if arg == nil? && block_given?
      result = start
      arr.my_each do |i|
        result =
          if result.nil?
            i
          else
            yield(result, i)
          end
      end
    elsif (start.class != Symbol && arg.nil?) && start.class ==
                                                 Integer
      warn "The value #{start} is not a symbol rep"
      abort
    elsif start.class == Symbol
      if start == :+
        result = arr.my_inject { |i, v| i + v }
      elsif start == :*
        result = arr.my_inject { |i, v| i * v }
      elsif start == :-
        result = arr.my_inject { |i, v| i - v }
      elsif start == :/
        result = arr.my_inject { |i, v| i / v }
      end
    elsif start.class == Integer && arg.class == Symbol
      new_arr = arr.to_a
      new_arr.unshift(start)
      result = new_arr.my_inject(arg)
    end
    result
  end

  # rubocop: enable Metrics/PerceivedComplexity, Metrics/CyclomaticComplexity

  def multiply_els(arr)
    arr.my_inject(:*)
  end
end

# rubocop: enable Style/CaseEquality:
