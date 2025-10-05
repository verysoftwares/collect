function find(tbl,who)
    for game,dev in ipairs(tbl) do if dev==who then return game end end
end

function dist(x1,y1,x2,y2)
    return math.sqrt((x2-x1)^2+(y2-y1)^2)
end