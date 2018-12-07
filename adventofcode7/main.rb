input = File.read("input").split("\n").map{|s| s.scan(/[A-Z]/).reverse[0..1]}

deps = Hash.new()
deps2 = Hash.new()

input.each{|x| deps[x[0]] = ""; deps[x[1]] = ""}
input.each{|x| deps[x[0]] = deps[x[0]] + x[1]}

input.each{|x| deps2[x[0]] = ""; deps2[x[1]] = ""}
input.each{|x| deps2[x[0]] = deps2[x[0]] + x[1]}

part1 = ""
while deps.length != 0
    nodeps = ""
    deps.each{|d,e| nodeps += d if e.length == 0}
    nodeps = nodeps.chars.min
    part1 += nodeps
    deps.delete(nodeps)
    deps.transform_values!{|v| v.gsub!(Regexp.new(nodeps), ""); next v}
end
puts part1

str = " ABCDEFGHIJKLMNOPQRSTUVWXYZ"
part2ord = ""
part2 = 0
nworkers = 5
workers = Array.new(nworkers){[0, nil]}
while deps2.length != 0
    nodeps = ""
    deps2.each{|d,e| nodeps += d if e.length == 0}
    nodeps = nodeps.chars.sort.take(nworkers)

    nodeps.each {|nd|
        workers.each_index {|i|
            if workers[i][1].nil? || workers[i][1].length == 0
                deps2.delete(nd)
                workers[i][0] = str.index(nd) + 60
                workers[i][1] = nd
                break
            end
        }
    }
    workernotfinished = true
    while workernotfinished
        part2 += 1
        workers.each_index {|i|
            if !workers[i][1].nil? && workers[i][1].length != 0
                workers[i][0] -= 1
                if workers[i][0] == 0
                    part2ord += workers[i][1]
                    deps2.transform_values!{|v| v.gsub!(Regexp.new(workers[i][1]), ""); next v}
                    workers[i][1] = ""
                    workernotfinished = false
                end
            end
        }
    end
end
puts part2