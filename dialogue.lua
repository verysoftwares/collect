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
                lineprint(200+40+40+40,sh-200-40+10)
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