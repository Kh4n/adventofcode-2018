require 'set'

input = File.read("input").split("\n")

twos = 0
threes = 0

input.each { |val|
    counts = val.each_char.group_by(&:itself).values.map(&:size)
    twos += 1 if counts.include?(2)
    threes += 1 if counts.include?(3)
}

puts twos*threes

input.each { |val|
    input.each { |val2|
        count = 0
        temp = 0;
        val.each_char.with_index { |c,i|
            (count += 1; temp = i) if (val[i] != val2[i])
            break if count > 1
        }
        (val.slice!(temp); puts val) if count == 1
    }
}
