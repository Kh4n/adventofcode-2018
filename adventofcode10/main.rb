require 'set'

input = File.read("input").split("\n").map{|x| x.scan(/[+-]?\d+/).map(&:to_i)}

center = [0,0]
center[0] = input.sum(0){|x,y,_,_| x}/input.length
center[1] = input.sum(0){|x,y,_,_| y}/input.length

part1 = input.dup
prevrange = 1.0/0.0
secs = 0
while true
    part1.each_index{|i|
        part1[i][0] += part1[i][2]
        part1[i][1] += part1[i][3]
    }
    range = part1.map{|x,y,_,_| y}.max - part1.map{|x,y,_,_| y}.min
    if range > prevrange
        break
    else
        prevrange = range
    end
    secs += 1
end
part1.each_index{|i|
    part1[i][0] -= part1[i][2]
    part1[i][1] -= part1[i][3]
}
set = Set.new(part1.map{|x,y,_,_| [x,y]})
(part1.map{|x,y,_,_| y}.min..part1.map{|x,y,_,_| y}.max).each{|y|
    (part1.map{|x,y,_,_| x}.min..part1.map{|x,y,_,_| x}.max).each{|x|
        if set.include?([x,y])
            print "#"
        else
            print " "
        end
    }
    puts
}

puts secs