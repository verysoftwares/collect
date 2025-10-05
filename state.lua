function freeform(dt)
    -- default game state
    mx,my = love.mouse.getPosition()
    lastclick = click
    click = love.mouse.isDown(1)

    for i=#scene,1,-1 do
        local obj = scene[i]
        if spriteclick(obj) then
            love.update = vanish
            obj.vanishing = 0
            return
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
        table.remove(scene,i)
    end end
end
