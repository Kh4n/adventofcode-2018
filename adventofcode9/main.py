from collections import deque

numplayers = 411
lastmarble = 71058*100
d = deque([0,1])
players  = [0] * numplayers
currplayer = 1
currmarble = 2

while currmarble <= lastmarble:
    if currmarble % 23 == 0:
        d.rotate(7)
        players[currplayer] += d.pop() + currmarble
        d.rotate(-1)
    else:
        d.rotate(-1)
        d.append(currmarble)
    currmarble += 1
    currplayer = (currplayer + 1) % numplayers
print max(players)