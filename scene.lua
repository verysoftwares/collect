function softreset()
    -- create a blank slate, apart from reloading all assets.
    scene = {}
    flags = {}

    script = {i=1,cur={function() end}}

    -- replace on scene transitions
    script_collect = function(obj) end
    script_use = function(obj) end

    inventory = {i=1,max=3}

    diagbox = {speaker=touko,w1=0,w2=0}
    line = {cur='',i=0,t=0}

    bg_img = nil

    love.update = freeform

    t = 0
end

function scene_launch(id)
    softreset()

    if id=='forest' then forest_reset() end
end