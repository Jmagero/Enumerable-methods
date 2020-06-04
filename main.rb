module Enumerable
  def my_each
    return enum_for unless block_given?

    my_arr = *self
    i = 0
    while i < my_arr.length
      yield my_arr[i]
      i += 1
    end
    my_arr
  end

  def my_each_with_index
    return enum_for unless block_given?

    my_arr = *self
    i = 0
    while i < my_arr.length
      yield my_arr[i], i
      i += 1
    end
    my_arr
  end

  def my_select
    return enum_for unless block_given?

    result = []
    my_each { |x| result << x if yield(x) }
    result
  end

  # rubocop: disable Metrics/PerceivedComplexity, Metrics/CyclomaticComplexity

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

  def my_none?(pattern = nil)
    return true if (self - [nil, false]) == [] || length < 2

    my_each_with_index do |x, i|
      if block_given?
        return false if yield x
      elsif pattern.class == Regexp
        return false if pattern =~ x
      elsif pattern.class == Class
        return false if x.class == pattern
      elsif !pattern.nil?
        return false if x == pattern
      elsif i.positive? && self[i] != self[i - 1]
        return false
      end
    end
    true
  end

  # rubocop: enable Metrics/PerceivedComplexity, Metrics/CyclomaticComplexity

  def my_count(arg = nil)
    return length if arg.nil? && !block_given?

    count = 0
    my_each do |x|
      if block_given?
        count += 1 if yield x
      elsif x == arg
        count += 1
      end
    end

    count
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
