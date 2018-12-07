i= -1;
input = File.read("input").split("\n").map{|x|
    i += 1
    x.split(", ").map(&:to_i).insert(0, i)
}

coords = Array.new(input.length, 0)
amax = input.flatten.max
area  = Array.new(amax) {Array.new(amax, "-2 100000000")}
area2  = Array.new(amax) {Array.new(amax, 0)}
def manhat(x,y, x1,y1)
    return (x-x1).abs + (y-y1).abs
end

input.each {|id, x, y|
    area.each_index{|xc|
        area[xc].each_index{|yc|
            aid, adist = area[xc][yc].split(" ").map(&:to_i)
            if manhat(x,y, xc,yc) < adist
                coords[aid] -= 1 if aid >= 0
                coords[id] += 1
                aid = id
                adist = manhat(x,y, xc,yc)
            elsif manhat(x,y, xc,yc) == adist
                coords[aid] -= 1 if aid >= 0
                aid = -1
            end
            area[xc][yc] = "#{aid} #{adist}"
        }
    }
}

area[0].each{|b| coords[b.split(" ")[0].to_i] = 0 if b.split(" ")[0].to_i != -1}
area.last.each{|b| coords[b.split(" ")[0].to_i] = 0 if b.split(" ")[0].to_i != -1}
area.each{|a| coords[a[0].split(" ")[0].to_i] = 0 if a[0].split(" ")[0].to_i != -1}
area.each{|a| coords[a[-1].split(" ")[0].to_i] = 0 if a[-1].split(" ")[0].to_i != -1}

puts coords.max

region = 0
area2.each_index {|xc|
    area2.each_index{|yc|
        region += 1 if input.each.sum(0){|idxy| manhat(idxy[1], idxy[2], xc, yc)} < 10000
    }
}

puts region