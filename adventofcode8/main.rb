input = File.read("input").split(" ").map(&:to_i)

part1arr = input.dup
part1 = []
while part1arr.length != 0
    (0..part1arr.length).step(2) {|i|
        if part1arr[i] == 0
            part1.concat(part1arr.slice!(i+2, part1arr[i+1]))
            part1arr.slice!(i, 2)
            part1arr[i-2] -= 1 if !part1arr[i-2].nil?
            break
        end
    }
end
puts part1.sum

part2arr = input.dup
part2cc = input.dup
while part2arr.length != 1
    sumsavoided = 0
    nnegsums = 0
    (0..part2arr.length).step(2) {|i|
        i -= nnegsums
        break if i >= part2arr.length
        if part2arr[i] < 0
            sumsavoided += 1
            nnegsums += 1
            next
        end
        if part2arr[i] == 0
            if part2cc[i] == 0
                part2cc.slice!(i+2, part2arr[i+1])
                sum = part2arr.slice!(i+2, part2arr[i+1]).sum
                part2arr.slice!(i)
                part2cc.slice!(i)
                part2arr[i] = -sum
                part2arr[i-2-sumsavoided] -= 1 if !part2arr[i-2-sumsavoided].nil?
                break
            else
                numchilds = part2cc[i]
                part2cc.slice!(i+2, numchilds)
                part2cc.slice!(i+2, part2arr[i+1])
                subnodevals = part2arr.slice!(i+2, numchilds)
                sum = 0
                part2arr.slice!(i+2, part2arr[i+1]).each{|md| sum += -subnodevals[md-1] if !subnodevals[md-1].nil?}
                part2arr.slice!(i)
                part2cc.slice!(i)
                part2arr[i] = -sum
                part2arr[i-2-sumsavoided] -= 1 if !part2arr[i-2-sumsavoided].nil?
                break
            end
        end
        sumsavoided = 0
    }
end
puts -part2arr[0]