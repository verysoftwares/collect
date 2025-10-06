function softreset()
    -- create a blank slate, apart from reloading all assets.
    scene = {}
    flags = {}

    script = {i=1,cur={function() end}}

    -- replace on scene transitions
    script_collect = function(obj) end
    script_use = function(obj) end

    if not inventory then inventory = {i=1,max=3} end

    diagbox = {speaker=touko,w1=0,w2=0}
    line = {cur='',i=0,t=0}

    bg_img = nil

    love.update = freeform

    t = 0
end

function scene_launch(id)
    softreset()

    -- could do the _G['%s_reset'] thing but i like seeing progress
    if id=='forest' then forest_reset() end
    if id=='home' then home_reset() end
    if id=='cafe' then cafe_reset() end
    if id=='wild' then wild_reset() end
end