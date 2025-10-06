scr_invmulti = {
    function() chat('Left and right keys scroll through items.',touko,'left and right') end,
    function() if scr_invmulti.next then script_start(scr_invmulti.next); scr_invmulti.next.i = nil end end,
}
scr_invfull = {
    function() chat('Would love to collect that, but inventory\'s full.',touko,'inventory\'s full') end,
}

function freeform(dt)
    -- default game state
    mx,my = love.mouse.getPosition()
    lastclick = click
    click = love.mouse.isDown(1)

    for i=#scene,1,-1 do
        local obj = scene[i]
        if spriteclick(obj) then
            if #inventory>=inventory.max then
                script_start(scr_invfull)
            else
                love.update = vanish
                obj.vanishing = 0
                return
            end
        end
    end

    -- hardcoded scene-specific behaviours go here,
    -- could have a dynamic table containing functions maybe.
        if flags.leafmove then leaf_move() end

    script_run() 

    inventoryscroll()
    if inventoryclick() then
        script_use(inventoryitem())
    end

    t = t+1
end

function vanish(dt)
    for i,obj in ipairs(scene) do if obj.vanishing then
        obj.vanishing = obj.vanishing+(obj.img:getHeight()/2-obj.vanishing)*0.1
        if obj.vanishing>=obj.img:getHeight()/2-1 then 
            obj.vanishing = nil; obj.gone = true
            table.insert(inventory,obj); inventory.i = #inventory
            script_collect(obj)
            if #inventory>1 and not scr_invmulti.seen then
                scr_invmulti.next = script.cur
                if scr_invmulti.next then scr_invmulti.next.i = script.i end
                script_start(scr_invmulti)
            end
            love.update = freeform
        end
    end end
    scene_clean()
end

function read(dt)
    -- in case we need to pause other activity to only read dialogue
    lastclick = click
    click = love.mouse.isDown(1)
    script_run()
end

function inventoryscroll()
    if not love.keyboard.isDown('left') and not love.keyboard.isDown('right') then keyhold = false end
    if love.keyboard.isDown('left') and not keyhold then--click and not lastclick and dist(mx,my,touko.x+touko.img:getWidth()/4-120,touko.y-60)<48 then
        inventory.i = inventory.i-1
        if inventory.i<1 then inventory.i = #inventory end
        keyhold = true
    end
    if love.keyboard.isDown('right') and not keyhold then--click and not lastclick and dist(mx,my,touko.x+touko.img:getWidth()/4+120,touko.y-60)<48 then
        inventory.i = inventory.i+1
        if inventory.i>#inventory then inventory.i = 1 end
        keyhold = true
    end
end

function scene_clean()
    for i=#scene,1,-1 do if scene[i].gone then 
        scene[i].gone = false
        table.remove(scene,i)
    end end
end
