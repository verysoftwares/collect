scr_enterhome = {
    function() appear(touko) end,
    function() chat('Honey I\'m hoooome!',touko,'honey i\'m home') end,
    function() chat('This is where I can safely store my collection.........',touko,'store my collection') end,
    function() if #inventory==0 then chat('OR I COULD IF I HAD ANY',touko,'if i had any') else script_next() end end,
}
scr_toforest = {
    function() chat('A map that takes me to the forest.',touko,'forest map') end,
    function() scene_launch('forest') end,
}
scr_tocafe = {
    function() chat('A map that takes me to the cafe.',touko,'cafe map') end,
    function() scene_launch('cafe') end,
}

function home_collect(obj)
    if obj.id=='cake' then 
    end
    if obj==map_forest then script_start(scr_toforest) end
    if obj==map_cafe then script_start(scr_tocafe) end
    if obj==arska then end
    if obj==touko then script_start(scr_selfie) end
end

function home_use(obj)
    --obj.x,obj.y = nextslot()
    --deposit(obj)
    obj.homex = rand(touko.img:getWidth()/2,sw-obj.img:getWidth()/2)
    obj.homey = rand(0,sh-200-40-obj.img:getHeight()/2)
    obj.x,obj.y=obj.homex,obj.homey
    deposit(obj,true)
    if obj==touko then script_start(scr_selfie2) end
end

function home_reset()
    bg_img = home_bg

    scene = home_scene or {touko,map_forest,map_cafe}
    home_scene = scene

    for i,obj in ipairs(home_scene) do
        obj.x = obj.homex or obj.x
        obj.y = obj.homey or obj.y
    end

    touko.x,touko.y = 0,sh-touko.img:getHeight()/2
    touko.x = touko.x-touko.img:getWidth()/2-20

    script_collect = home_collect
    script_use = home_use

    script_start(scr_enterhome)
end
