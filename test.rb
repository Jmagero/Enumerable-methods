# load 'main.rb'

# # TEST CASES FOR ALL METHODS
# # Test cases for my_each
# puts [1, 2, 3].my_each { |elem| print "#{elem + 1} "}
# array = Array.new(100) { rand(0...9) }
# array.my_each == Enumerator # should return true
# # Test cases for my_each_with_index
# print [1, 2, 3].my_each_with_index { |elem, idx| puts "#{elem} : #{idx}" }
# # => 1 : 0, 2 : 1, 3 : 2
# array = Array.new(100) { rand(0...9) }
# array.my_each_with_index == Enumerator # should return true
# # Test cases for my_select
# array = Array.new(100){rand(0...9)}
# array.my_select == Enumerator # should return true
# p [1,2,3,8].my_select { |n| n.even? } # => [2, 8]
# p [0, 2018, 1994, -7].my_select { |n| n > 0 } # => [2018, 1994]
# p [6, 11, 13].my_select(&:odd?) # => [11, 13]
# # Test cases for my_all?
# arr = [2, 4, 6, 8]
# arr. my_all? { |item| item % 2 == 0}
# arr = ["food", "bread", "mat", "rat"]
# arr.my_all? { |item| item.length == 3}
# true_array = [1, true, 'hi', []]
# true_array.my_all?
# array = Array.new(100){rand(0...9)}
# array.my_all?(Integer)
# words = %w[dog door rod blade]
# words.my_all?(/d/)
# # Test cases for my_any?
# true_array = [nil, false, true, []]
# true_array.my_any? == true_array.any? #true
# words = %w[dog door rod blade]
# words.my_any?(Integer) == words.any?(Integer) #true
# words.my_any?(/z/) == words.any?(/z/) #true
# words.my_any?('cat') == words.any?('cat') #true
# p [7, 10, 3, 5].my_any? { |n| n.even? } # => true
# p [7, 10, 4, 5].my_any?() { |n| n.even? } # => true
# p ["q", "r", "s", "i"].my_any? { |char| "aeiou".include?(char) } # => true
# p [7, 11, 3, 5].my_any? { |n| n.even? } # => false
# p ["q", "r", "s", "t"].my_any? { |char| "aeiou".include?(char) } # => false
# p [nil, false, nil, false].my_any? # => false
# p [1, nil, false].my_any?(Integer) # => true
# p ['dog', 'door', 'rod', 'blade'].my_any?(/z/) # => false
# p [1, 2 ,3].my_any?(1) # => true
# # Test cases for my_none?
# array = Array.new(100) { rand(0...9) }
# array.my_none?(String) == true #true
# words = %w[dog door rod blade]
# words.my_none?(5) == words.none?(5) #true
#  words.my_none?(/z/) == words.none?(/z/) #true
#  words.my_none?(/f/) == words.none?(/f/) #true
#  true_array = [nil, false, true, []]
# false_array = [nil, false, nil, false]
# false_array.my_none? #true
# true_array.my_none? #false
# # Test cases for my_count
# array = Array.new(100){rand(0...9)}
# array.my_count == array.count #true
# array.my_count(0) == array.count(0) # should return true
# p [1,4,3,8].my_count { |n| n.even? } # => 2
# p ["DANIEL", "JIA", "KRITI", "dave"].my_count { |s| s == s.upcase } # => 3
# p ["daniel", "jia", "kriti", "dave"].my_count { |s| s == s.upcase } # => 0
# p [1,2,3].my_count # => 3
# p [1,1,1,2,3].my_count(1) # => 3
# # Test cases for my_map
# array.my_map == Enumerator # should return true
# p [1,2,3].my_map { |n| 2 * n } # => [2,4,6]
# p ["Hey", "Jude"].my_map { |word| word + "?" } # => ["Hey?", "Jude?"]
# p [false, true].my_map { |bool| !bool } # => [true, false]
# my_proc = Proc.new {|num| num > 10 }
# p [18, 22, 5, 6].my_map(my_proc) {|num| num < 10 } # => true true false false
# # Test cases for my_inject
# array = Array.new(100) { rand(0...9) }
# array.my_inject(:+) == array.inject(:+) # should return true
# operation = proc { |sum, n| sum + n }
# search = proc { |memo, word| memo.length > word.length ? memo : word }
# array = Array.new(100){rand(0...9)}
# words = %w[dog door rod blade]
# array.my_inject(&operation) == array.inject(&operation) # should return true
# words.my_inject(&search) == words.inject(&search) # should return true
# p [1,2,3,4].my_inject(10) { |accum, elem| accum + elem} # => 20
# p [1,2,3,4].my_inject { |accum, elem| accum + elem} # => 10
# p [5, 1, 2].my_inject("+") # => 8
# p (5..10).my_inject(2, :*) # should return 302400
# p (5..10).my_inject(4) {|prod, n| prod * n} # should return 604800
