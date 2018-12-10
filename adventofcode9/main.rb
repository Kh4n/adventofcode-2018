require 'rubygems/util/list'

input = File.read("input").chomp.scan(/\d+/).map(&:to_i)

totalplayers = input[0]
lastmarble = input[1]
circle = [0,1]
currplayer = 1
players = Array.new(totalplayers, 0)
currmarble = 2
i = 1
data = []
while currmarble <= lastmarble
    if currmarble % 23 == 0
        players[currplayer] += currmarble
        i = (i-9) % circle.length
        players[currplayer] += circle[i]
        data << circle[i]
        circle.slice!(i)
    else
        circle.insert(i, currmarble)
    end
    currmarble += 1
    i = (i+2) % circle.length
    currplayer = (currplayer+1) % totalplayers
end
puts players.max