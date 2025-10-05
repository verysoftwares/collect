function spritedraw(obj)
    -- automatic scaling & rotation around center & vanishing
    local ox,oy=0,0
    if obj.vanishing then ox=sin(obj.vanishing*0.25)*12; lg.setScissor(obj.x+ox,obj.y+obj.vanishing,obj.img:getWidth()/2+oy,obj.img:getHeight()/2-obj.vanishing) end
    lg.draw(obj.img,obj.x+obj.img:getWidth()/4+ox,obj.y+obj.img:getHeight()/4+oy,sin(t*0.05)*0.06,0.5,0.5,obj.img:getWidth()/2,obj.img:getHeight()/2)
    lg.setScissor()
end

function imagehover(obj,ix,iy)
    -- returns whether mouse is colliding with non-rotated image.
    if ix>=0 and iy>=0 and ix<obj.img:getWidth() and iy<obj.img:getHeight() then
        local r,g,b,a = obj.imgdata:getPixel(ix,iy)
        if a>0 then return true end
    end
    return false
end

function inventorydraw()
    if #inventory==0 then return end
    local obj = inventoryitem()
    
    fg(1,1,1,1)
    if inventoryhover(obj) then fg(0.4,1,0.4,1) end
    lg.draw(obj.img,touko.x+touko.img:getWidth()/4,touko.y+obj.img:getHeight()/4-obj.img:getHeight()/2,sin(t*0.05)*0.06,0.5,0.5,obj.img:getWidth()/2,obj.img:getHeight()/2)

    --fg(0.6-0.2,0.6-0.2,0.6-0.2,1)
        --lg.circle('fill',touko.x+touko.img:getWidth()/4-120,touko.y-60,48)
        --lg.circle('fill',touko.x+touko.img:getWidth()/4+120,touko.y-60,48)
        --lg.setFont(touko.fontbig)
            --fg(0.4-0.15,0.8-0.15,0.5-0.15)
            --lg.print('<',touko.x+touko.img:getWidth()/4-120-35,touko.y-60-85)
            --lg.print('>',touko.x+touko.img:getWidth()/4+120-35,touko.y-60-85)

    fg(1,1,1,1)
end

function spritehover(obj)
    local ix,iy = (mx-obj.x)*2,(my-obj.y)*2
    return imagehover(obj,ix,iy)
end

function spriteclick(obj)
    return click and not lastclick and spritehover(obj)
end

function inventoryhover(obj)
    local ix,iy = (mx-(touko.x+touko.img:getWidth()/4-obj.img:getWidth()/4))*2,(my-(touko.y-obj.img:getHeight()/2))*2
    return imagehover(obj,ix,iy)
end

function inventoryclick()
    return #inventory>0 and click and not lastclick and inventoryhover(inventoryitem())
end

function inventoryitem()
    return inventory[inventory.i]
end