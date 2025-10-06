scr_enterhome = {
    function() appear(touko) end,
    function() chat('Honey I\'m hoooome!') end,
    function() chat('This is where I can safely store my collection.........') end,
    function() if #inventory==0 then chat('OR I COULD IF I HAD ANY') else script_next() end end,
}

function home_collect(obj)
    if obj.id=='cake' then 
    end
    if obj==arska then end
    if obj==touko then script_start(scr_selfie) end
end

function home_use(obj)
    --obj.x,obj.y = nextslot()
    --deposit(obj)
    if obj==touko then script_start(scr_selfie2) end
end

function home_reset()
    bg_img = home_bg

    scene = home_scene or {touko,drums,phone}
    home_scene = scene

    touko.x,touko.y = 0,sh-touko.img:getHeight()/2
    touko.x = touko.x-touko.img:getWidth()/2-20

    script_collect = home_collect
    script_use = home_use

    script_start(scr_enterhome)
end
