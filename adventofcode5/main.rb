input = File.read("input").chomp.split("")

def reduce(str)
    stack = []
    while str.length != 0
        e = str.pop()
        if stack[-1] == e.swapcase
            stack.pop()
        else
            stack.push(e)
        end
    end
    return stack
end

puts reduce(input.dup).length
puts "abcdefghijklmnopqrstuvwxyz".split("").map {|c|
    reduce(input.reject{|e| e.casecmp(c) == 0}).length
}.min