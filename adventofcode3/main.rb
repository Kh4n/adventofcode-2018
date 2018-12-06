require 'set'

input = File.read("input").split("\n").map{|x| [x.split(" ")[2].chomp(":").split(","), x.split(" ")[3].chomp(":").split("x"), x.split(" ")[0][1..-1]].flatten.map(&:to_i)}

arr = Array.new(1000) {Array.new(1000)}
arr.each { |i|
    i.map!{|x| 0}
}

input.each { |c|
    (c[0]..(c[0]+c[2]-1)).each { |i|
        (c[1]..(c[1]+c[3]-1)).each { |j|
            arr[i][j] += 1
        }
    }
}

count = 0
arr.flatten.each{|x| (count += 1) if x >= 2}
puts count

input.each { |c|
    catch :taken do
    (c[0]..(c[0]+c[2]-1)).each { |i|
        (c[1]..(c[1]+c[3]-1)).each { |j|
            throw :taken if (arr[i][j] > 1)
        }
    }
    puts c[4]
    break
    end
}