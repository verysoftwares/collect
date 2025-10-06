scr_entercafe = {
    function() waitclick() end,
    function() appear(touko) end,
    function() chat('Hmm jaahas! Lots of tasty treats here for me!') end,
}
scr_cakeadmire = {
    function() chat('Can\'t have my cake and eat it too.') end,
}
scr_cakeget = {
    function() chat('Yeah I\'ll be taking this one.') end,
    function() if #inventory==inventory.max then script_start(scr_steal) end; script_next() end,
}
scr_cakeget2 = {
    function() chat('Aaand this one.') end,
    function() if #inventory==inventory.max then script_start(scr_steal) end; script_next() end,
}
scr_cakeget3 = {
    function() chat('Well maybe just one more for good measure.') end,
    function() script_start(scr_steal); script_next() end,
}
scr_steal = {
    function() brace_interrupt(); chat('Well uuhhh guess I can\'t carry anything more.') end,
    function() appear(arska) end,
    function() if t-sc_t==0 then flags.steal = true end; chat('Aaand how you gonna pay for all that.',arska) end,
    function() chat('Show some.',arska) end,
    function() chat('Show some.',arska) end,
    function() chat('This is usually where .',arska) end,
}
scr_cantpay = {
    function() brace_interrupt(); chat('May I interest you in this rare artifact?') end,
    function() chat('You can\'t pay me with something you just stole from me!',arska) end,
    function() chat('You gotta offer some kinda value proposition.',arska) end,
    function() chat('This is why this city is so ass.',arska) end,
    function() chat('It\'s assinine, assturbo, turboass, getcho ass,',arska) end,
    function() chat('ass-to-ass, ass-backwards, backwards-ass, ass salad,',arska) end,
    function() chat('assumptious, asstronomy, asswipe, ass master,',arska) end,
    function() chat('got a PhD in ass, ass on the line, 1-800-ASS,',arska) end,
    function() chat('My point being: this is an ass city!',arska) end,
    function() waithard(90); --[[sfx('cheer')]] end,
}

function cafe_collect(obj)
    if obj.id=='cake' then 
        if not scr_cakeget.seen then script_start(scr_cakeget)
        elseif not scr_cakeget2.seen then script_start(scr_cakeget2)
        else script_start(scr_cakeget3) end
    end
    if obj==arska then end
    if obj==touko then script_start(scr_selfie) end
end

function cafe_use(obj)
    if obj.id=='cake' then
        if flags.steal then script_start(scr_cantpay)
        else script_start(scr_cakeadmire) end
    end
    if obj==touko then script_start(scr_selfie2) end
end

function cafe_reset()
    bg_img = cafe_bg

    scene = {touko,cake1,cake2,cake3,arska}

    touko.x,touko.y = 0,sh-touko.img:getHeight()/2
    touko.x = touko.x-touko.img:getWidth()/2-20

    arska.x,arska.y = sw+20,sh-400-arska.img:getHeight()/2+150
    
    cake1.x,cake1.y = 250,100
    cake2.x,cake2.y = 250+180,100+120
    cake3.x,cake3.y = 250+180*2,100+120*2

    script_collect = cafe_collect
    script_use = cafe_use

    script_start(scr_entercafe)
end
