input = File.read("input").split("\n").sort.map{|line|
    hour = line.scan(/\d+/)[3].to_i
    min = 0;
    min = line.scan(/\d+/)[4].to_i if hour == 0
    [min, line.match(/(wakes|falls|#\d+)/)[0]]
}   

guards = Hash.new{|k,v| k[v] = Array.new(60,0)}
currguard = ""
prevtime = 0
input.each{|time, action|
    if (action[0] == "#")
        currguard = action
    elsif (action[0] == "w")
        guards[currguard][prevtime..time-1] = guards[currguard][prevtime..time-1].map{|x| x + 1}
    end
    prevtime = time
}

puts guards.max_by{|k,v| v.sum}[0][1..-1].to_i * guards.max_by{|k,v| v.sum}[1].index(guards.max_by{|k,v| v.sum}[1].max)
puts guards.max_by{|k,v| v.max}[0][1..-1].to_i * guards.max_by{|k,v| v.max}[1].index(guards.max_by{|k,v| v.max}[1].max)