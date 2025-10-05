lg = love.graphics
bg = lg.clear
fg = lg.setColor
sin = math.sin
rand = love.math.random

touko = {}
touko.imgdata = love.image.newImageData('/assets/chars/touko.png')
touko.img = lg.newImage(touko.imgdata)
touko.font = lg.newFont('/assets/fonts/Super Joyful.ttf',48+8+8)
touko.fontsmol = lg.newFont('/assets/fonts/Super Joyful.ttf',28+12)
touko.fontbig = lg.newFont('/assets/fonts/Super Joyful.ttf',142)
touko.id = 'Touko'
touko.col = {r=0.4-0.15,g=0.8-0.15,b=0.5-0.15}
touko.x,touko.y = 0,sh-touko.img:getHeight()/2
touko.x = touko.x-touko.img:getWidth()/2-20
mumina = {}
mumina.imgdata = love.image.newImageData('/assets/chars/mumina.png')
mumina.img = lg.newImage(mumina.imgdata)
mumina.font = lg.newFont('/assets/fonts/Bigbesty.ttf',48+8+8)
mumina.fontsmol = lg.newFont('/assets/fonts/Bigbesty.ttf',28+12)
mumina.id = 'Mumina'
mumina.col = {r=0.8-0.15-0.1,g=0.4-0.15-0.1,b=0.7-0.15-0.1}
mumina.x,mumina.y = sw+20,sh-400-mumina.img:getHeight()/2+150
leaf1 = {}
leaf1.imgdata = love.image.newImageData('/assets/items/leaf-1.png')
leaf1.img = lg.newImage(leaf1.imgdata)
leaf1.x,leaf1.y = 400+50,500-200-80-20
leaf2 = {}
leaf2.imgdata = love.image.newImageData('/assets/items/leaf-2.png')
leaf2.img = lg.newImage(leaf2.imgdata)
leaf2.x,leaf2.y = 700+50,250-100-80-20
leaf3 = {}
leaf3.imgdata = love.image.newImageData('/assets/items/leaf-3.png')
leaf3.img = lg.newImage(leaf3.imgdata)
leaf3.x,leaf3.y = 700+50+60,250-100-80-20+80

leaf1.x = leaf1.x+500; leaf1.y = leaf1.y-450
leaf2.x = leaf2.x+500; leaf2.y = leaf2.y-450
leaf3.x = leaf3.x+500; leaf3.y = leaf3.y-450
leaf1.bx=leaf1.x;leaf2.bx=leaf2.x;leaf3.bx=leaf3.x;leaf1.by=leaf1.y;leaf2.by=leaf2.y;leaf3.by=leaf3.y

flags = {}

scene = {touko,leaf1,leaf2,leaf3,mumina}

inventory = {i=1,max=3}

function scene_clean()
    for i=#scene,1,-1 do if scene[i].gone then 
        table.remove(scene,i)
    end end
end

bg_img = lg.newImage('/assets/photo/forest-1.jpg')
bg_col = {r=0.6-0.2,g=0.6-0.2,b=0.6-0.2}
main_canvas = lg.newCanvas(sw,sh)

t = 0
function freeform(dt)
    mx,my = love.mouse.getPosition()
    lastclick = click
    click = love.mouse.isDown(1)

    for i=#scene,1,-1 do
        local obj = scene[i]
        if spriteclick(obj) then
            love.update = vanish
            obj.vanishing = 0
            break
        end
    end
    if flags.leafmove then leaf_move() end
    if not (love.update==vanish) then 
        script_run() 
        if inventoryclick() then
            script_use(inventoryitem())
        end
    end

    t = t+1
end

love.update = freeform

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
    lastclick = click
    click = love.mouse.isDown(1)
    script_run()
end

script = {i=1,cur={function() end}}
line = {i=0,t=0,cur=''}
diagbox = {speaker=touko,w1=0,w2=0}

-- these contain functions run once per frame
-- use script_next() to move on
scr_hello = {
    --function() if t-sc_t>=40 then script_next() end end,
    function() if t-sc_t==0 then script.anyway = script.cur end; if click and not lastclick then script_next() end end,
    function() touko.x = touko.x+(0-touko.x)*0.1; if t-sc_t>=50 then script_next() end end,
    function() chat('Hmm jaahas! Today I shall collect the entire world!') end,
    function() chat('I will be respected and remembered!'); if t-sc_t==0 then flags.leafmove = true end end,
    function() chat('I am the greatest!'); if not flags.leafmove then flags.leafmove = true end end,
}
scr_leaf3 = {
    function() if t-sc_t==0 then script.anyway = script.cur end; chat('Alright, I\'ve collected the whole forest.') end,
    function() chat('I\'m overworked! Better head home...........') end,
    function() if t-sc_t==0 then line.cur='' end; if (t-sc_t==160) or (click and not lastclick) then script_next() end end,
    function() chat('Uuh but how??') end,
    function() mumina.x=mumina.x+(sw-mumina.img:getWidth()/2-mumina.x)*0.1; chat('Need a ride?',mumina) end,
    function() chat('How much will it cost?') end,
}
scr_leaf1 = {
    function() chat('Such an arduous quest... but I\'ve finally found it.') end,
    function() chat('A leaf that might unlock my hidden potential..........') end,
}
scr_leaf2 = {
    function() chat('Quite the house of leaves you\'re building here.') end,
    function() chat('Would be a shame if someone blew on it.............') end,
}
scr_selfie = {
    function() chat('lmao now I\'m in my own inventory') end,
    function() chat('uuuuuhhh how do I get out actually hmm jaahas............') end,
}
scr_selfie2 = {
    function() chat('Fine, I\'ll put myself back.') end,
    function() deposit(touko) end,
}
scr_anyway = {
    function() chat('Anyway.......',diagbox.speaker) end,
    function() local aw = script.anyway; script.anyway.i = nil; script.anyway = nil; script_start(aw) end,
}

function chat(ln,speaker)
    if not (ln==line.cur) then
        line.cur = ln
        line.i = 0; line.t = 0
        speaker = speaker or touko
        diagbox.speaker = speaker
        return
    end

    if click and not lastclick then
        love.update = freeform
        diagbox.w1 = 1; diagbox.w2 = 1
        if line.i<#line.cur+1 then line.i = #line.cur+1
        else script_next() end
        return
    end

    -- this can go longer than the length of the line
    -- because of an animation that's accounted for in line_print.
    if line.t%2==0 and diagbox.w1>0.5 then line.i = line.i+1 end

    line.t = line.t+1
end

function script_start(scr)
    -- store what was interrupted
    if script.cur==script.anyway then
        if linedone() then 
            script.anyway.i = script.i+1
            if script.anyway.i>#script.anyway then
                script.anyway.i = nil
                script.anyway = nil
            end
        else script.anyway.i = script.i end
    end

    script.cur = scr
    script.i = scr.i or 1
    scr.seen = true
    sc_t = t
end

function script_run()
    local active = script.cur[script.i]
    if active then active()
    else 
        if script.anyway and not (script.cur==script.anyway) then
            script_start(scr_anyway)
        else line.cur='' end
    end
end

function script_next()
    script.i = script.i+1
    sc_t = t
    script_run()
end

function script_collect(obj)
    if obj==leaf1 or obj==leaf2 or obj==leaf3 then 
        if not scr_selfie.seen then
            if not scr_leaf1.seen then script_start(scr_leaf1)
            elseif not scr_leaf2.seen then script_start(scr_leaf2)
            else script_start(scr_leaf3) end
        end
    end
    if obj==touko then script_start(scr_selfie) end
end

function script_use(obj)
    if obj==leaf1 or obj==leaf2 or obj==leaf3 then
        script_start(scr_leafadmire)
    end
    if obj==touko then script_start(scr_selfie2) end
end

script_start(scr_hello)
--script_start(scr_leaf3)
--table.insert(inventory,leaf1)

function find(tbl,who)
    for game,dev in ipairs(tbl) do if dev==who then return game end end
end

function dist(x1,y1,x2,y2)
    return math.sqrt((x2-x1)^2+(y2-y1)^2)
end

function deposit(obj)
    -- helper function intended to be used at the end of inventory clicking scripts.
    table.remove(inventory,find(inventory,obj)); if #inventory>0 and inventory.i>#inventory then inventory.i=#inventory end; table.insert(scene,obj); obj.gone=false; script_next()
end

function leaf_move()
    leaf1.bx = leaf1.bx - 1.5; leaf1.x = leaf1.bx + sin(t*0.02)*125
    leaf2.bx = leaf2.bx - 1.5; leaf2.x = leaf2.bx + sin(t*0.021)*120
    leaf3.bx = leaf3.bx - 1.5; leaf3.x = leaf3.bx + sin(t*0.038)*135
    leaf1.by = leaf1.by + 1.15; leaf1.y = leaf1.by + sin(t*0.012)*40
    leaf2.by = leaf2.by + 1.15; leaf2.y = leaf2.by + sin(t*0.014)*42
    leaf3.by = leaf3.by + 1.15; leaf3.y = leaf3.by + sin(t*0.024)*36
end

function love.draw()
    lg.setCanvas(main_canvas)
        --bg(0.8-0.6,0.8-0.6,0.8-0.6,1.0)
        lg.draw(bg_img,-120,-60)

        dialoguedraw()

        fg(1,1,1,1)
            inventorydraw()

            for i,obj in ipairs(scene) do
                spritedraw(obj)
            end
            for i=#scene,1,-1 do
                local obj = scene[i]
                if spritehover(obj) then fg(0.4,1,0.4,1); spritedraw(obj); break end
            end

            --if #inventory>0 then
                --lg.setFont(touko.font)
                    --fg(0.4-0.15,0.8-0.15,0.5-0.15)
                    --local msg = string.format('< %d/%d >',#inventory,inventory.max)
                    --lg.print(msg,touko.x+touko.img:getWidth()/4-lg.getFont():getWidth(msg)/2,touko.y-20)
            --end

    lg.setCanvas()
        fg(1,1,1,1)
        lg.draw(main_canvas,0,0)
end

function dialoguedraw()
    local obj = diagbox.speaker

    local name_w = 400*diagbox.w2
        fg(obj.col.r,obj.col.g,obj.col.b,1)
            if name_w>1 then
                lg.circle('fill',200,sh-200-40-70+60/2,60/2)
                lg.rectangle('fill',200,sh-200-40-70,name_w,60)
                lg.circle('fill',200+name_w,sh-200-40-70+60/2,60/2)
            end
        fg(bg_col.r,bg_col.g,bg_col.b)
            lg.setFont(obj.font)
            lg.setScissor(200,0,name_w,sh)
            lg.print(obj.id,
                     200+40+40+40,sh-200-40-70+60/2-obj.font:getHeight()/2)
            lg.setScissor()

    local line_w = 800*diagbox.w1
        fg(bg_col.r,bg_col.g,bg_col.b)
            if line_w>1 then
                lg.circle('fill',200,sh-200-40+200/2,200/2)
                lg.rectangle('fill',200,sh-200-40,line_w,200)
                lg.circle('fill',200+line_w,sh-200-40+200/2,200/2)
            end
        fg(obj.col.r,obj.col.g,obj.col.b,1)
            lg.setFont(obj.font)
            if #line.cur>0 then
                diagbox.w1 = diagbox.w1+(1-diagbox.w1)*0.1
                diagbox.w2 = diagbox.w2+(1-diagbox.w2)*0.1
                lineprint(200+40+40+40,sh-200-40+20)
            else
                diagbox.w1 = diagbox.w1+(0-diagbox.w1)*0.1
                diagbox.w2 = diagbox.w2+(0-diagbox.w2)*0.1
            end

    if linedone() then--and not line.auto
        local adv_w = obj.fontsmol:getWidth('Click to advance.')+40

        fg(obj.col.r,obj.col.g,obj.col.b)
            lg.circle('fill',680,sh-50-10+40/2,40/2)
            lg.rectangle('fill',680,sh-50-10,adv_w,40)
            lg.circle('fill',680+adv_w,sh-50-10+40/2,40/2)
        fg(bg_col.r,bg_col.g,bg_col.b,1)
            lg.setFont(obj.fontsmol)
            lg.print('Click to advance.',
                     680+40/2,sh-50-10+40/2-obj.fontsmol:getHeight()/2)
    end
end

function lineprint(sx,sy)
    -- animate new line of dialogue
    local lx,ly = sx,sy
    for i=1,math.min(line.i,#line.cur) do
        local char = string.sub(line.cur,i,i)
        if i==line.i and not (char==' ') then 
            if not (love.update==vanish) then randchar = string.char(rand(33,126)) end
            char = randchar
        end
        lg.print(char,lx,ly+sin(i*0.82+t*0.12)*2)
        lx = lx+lg.getFont():getWidth(char)
        if char==' ' and not lineroom(lx-sx,string.sub(line.cur,i+1,#line.cur)) then
            ly = ly+lg.getFont():getHeight()
            lx = sx
        end
    end
end

function lineroom(linelen,restmsg)
    -- returns whether next word fits on line.
    local nextword
    local nextspace = string.find(restmsg,' ')
    if not nextspace then nextword = string.sub(restmsg,1,#restmsg) 
    else nextword = string.sub(restmsg,1,nextspace) end
    return linelen+lg.getFont():getWidth(nextword) < 740
end

function linedone()
    return #line.cur>0 and line.i>=#line.cur+1
end

function spritedraw(obj)
    -- automatic scaling & rotation around center & vanishing
    local ox,oy=0,0
    if obj.vanishing then ox=sin(obj.vanishing*0.25)*12; lg.setScissor(obj.x+ox,obj.y+obj.vanishing,obj.img:getWidth()/2+oy,obj.img:getHeight()/2-obj.vanishing) end
    lg.draw(obj.img,obj.x+obj.img:getWidth()/4+ox,obj.y+obj.img:getHeight()/4+oy,sin(t*0.05)*0.06,0.5,0.5,obj.img:getWidth()/2,obj.img:getHeight()/2)
    lg.setScissor()
end

function spritehover(obj)
    -- returns whether mouse is colliding with non-rotated image.
    local ix,iy = (mx-obj.x)*2,(my-obj.y)*2
    if ix>=0 and iy>=0 and ix<obj.img:getWidth() and iy<obj.img:getHeight() then
        local r,g,b,a = obj.imgdata:getPixel(ix,iy)
        if a>0 then return true end
    end
    return false
end

function spriteclick(obj)
    return click and not lastclick and spritehover(obj)
end

function inventorydraw()
    if #inventory==0 then return end
    local obj = inventoryitem()
    fg(1,1,1,1)
    if inventoryhover(obj) then fg(0.4,1,0.4,1) end
    lg.draw(obj.img,touko.x+touko.img:getWidth()/4,touko.y+obj.img:getHeight()/4-obj.img:getHeight()/2,sin(t*0.05)*0.06,0.5,0.5,obj.img:getWidth()/2,obj.img:getHeight()/2)

    fg(0.6-0.2,0.6-0.2,0.6-0.2,1)
        --lg.circle('fill',touko.x+touko.img:getWidth()/4-120,touko.y-60,48)
        if not love.keyboard.isDown('left') and not love.keyboard.isDown('right') then keyhold = false end
        if love.keyboard.isDown('left') and not keyhold then--click and not lastclick and dist(mx,my,touko.x+touko.img:getWidth()/4-120,touko.y-60)<48 then
            inventory.i = inventory.i-1
            if inventory.i<1 then inventory.i = #inventory end
            keyhold = true
        end
        --lg.circle('fill',touko.x+touko.img:getWidth()/4+120,touko.y-60,48)
        if love.keyboard.isDown('right') and not keyhold then--click and not lastclick and dist(mx,my,touko.x+touko.img:getWidth()/4+120,touko.y-60)<48 then
            inventory.i = inventory.i+1
            if inventory.i>#inventory then inventory.i = 1 end
            keyhold = true
        end
        --lg.setFont(touko.fontbig)
            --fg(0.4-0.15,0.8-0.15,0.5-0.15)
            --lg.print('<',touko.x+touko.img:getWidth()/4-120-35,touko.y-60-85)
            --lg.print('>',touko.x+touko.img:getWidth()/4+120-35,touko.y-60-85)

    fg(1,1,1,1)
end

function inventoryhover(obj)
    local ix,iy = (mx-(touko.x+touko.img:getWidth()/4-obj.img:getWidth()/4))*2,(my-(touko.y-obj.img:getHeight()/2))*2
    if ix>=0 and iy>=0 and ix<obj.img:getWidth() and iy<obj.img:getHeight() then
        local r,g,b,a = obj.imgdata:getPixel(ix,iy)
        if a>0 then return true end
    end
    return false
end

function inventoryclick()
    return #inventory>0 and click and not lastclick and inventoryhover(inventoryitem())
end

function inventoryitem()
    return inventory[inventory.i]
end