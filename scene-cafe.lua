scr_entercafe = {
    function() appear(touko) end,
    --function() chat('All the cakes are at home!') end,
    function() chat('Hmm jaahas! Lots of tasty treats here for me!',touko,'tasty treats') end,
    function() if #inventory==inventory.max then script_start(scr_cafefull) else script_next() end end,
}
scr_cafefull = {
    function() chat('But my inventory is already full so why am I here!',touko,'why am i here') end,
    function() scene_launch('home') end,
}
scr_cakeadmire = {
    function() chat('Can\'t have my cake and eat it too.',touko,'have my cake') end,
}
scr_cakeget = {
    function() chat('Yeah I\'ll be taking this one.',touko,'taking this one') end,
    function() if #inventory==inventory.max then script_start(scr_steal) else script_next() end end,
}
scr_cakeget2 = {
    function() chat('Aaand this one.',touko,'aaand this one') end,
    function() if #inventory==inventory.max then script_start(scr_steal) else script_next() end end,
}
scr_cakeget3 = {
    function() chat('Well maybe just one more for good measure.',touko,'for good measure') end,
    function() script_start(scr_steal) end,
}
scr_steal = {
    function() brace_interrupt(); chat('Uuhhh guess I can\'t carry anything more now.',touko,'carry anything more now') end,
    function() appear(arska) end,
    function() if t-sc_t==0 then flags.steal = true end; chat('Aaand how you gonna pay for all that.',arska,'how you gonna pay'); if linedone() and scene.anyway then scene.anyway.i = nil; scene.anyway = nil end end,
    function() chat('Let\'s see some wares.',arska,'see some wares') end,
    -- offer something here or face madness
    function() waithard(300) end,
    function() chat('This is usually the part where people pay me.',arska,'part where people pay me') end,
    function() chat('Yeah I\'m just getting my change ready.',touko,'change ready') end,
    function() chat('Ahaa.',arska,'ahaa') end,
    function() waithard(300) end,
    function() chat('Any minute now.',arska,'any minute now') end,
    function() chat('Yeah my paw has almost reached the wallet.',touko,'reached the wallet') end,
    function() chat('Hmm jaahas.',arska,'hmm jaahas') end,
    function() waithard(160) end,
    function() chat('It\'s',touko,'it\'s'); waithard(50) end,
    function() chat('It\'s an ongoing plan to reach my pocket.',touko,'ongoing plan') end,
    function() chat('Which, rest assured, I am fully committed to.',touko,'fully committed to') end,
    function() chat('mm',arska,'mm'); waithard(30) end,
    function() waithard(300-20) end,
    function() chat('your taking too long is taking too long!',arska,'your taking too long') end,
    function() chat('My code\'s still compiling.','compiling') end,
    function() chat('My brother in Christ Lua is an interpreted language.',arska,'brother in christ') end,
}
scr_cantpay = {
    function() brace_interrupt(); chat('May I interest you in this rare artifact?','rare artifact') end,
    function() chat('You can\'t pay me with something you just stole from me!',arska,'stole from me') end,
    function() chat('You gotta offer some kinda, value proposition.',arska,'value proposition') end,
    function() chat('This is why this city is so ass.',arska,'city is so ass') end,
    function() chat('It\'s assinine, turboass, assturbo, getcho ass,',arska,'turboass') end,
    function() chat('ass-to-ass, ass-backwards, backwards-ass, ass salami,',arska,'ass salami') end,
    function() chat('assumptious, asstronomy, wipe yo ass, ass blaster,',arska,'ass blaster') end,
    function() chat('got a PhD in ass, ass on the line, 1-800-ASS,',arska,'1-800-ASS') end,
    function() chat('My point being: this is an ass city!',arska,'ass city') end,
    function() chat('',nil,'cheers'); waithard(170) end,
    function() script_start(scr_canileave) end,
}
scr_leafpay = {
    function() chat('We\'ve already got a vegetarian menu.',arska,'vegetarian menu') end,
}
scr_locatecafe = {
    function() chat('You think I can\'t locate where we are?',arska,'locate where we are') end,
}
scr_canileave = {
    function() chat('Soooooo can I leave now??',touko,'can i leave now') end,
    function() chat('dunno lol it\'s not like I work here',arska,'dunno lol'); if not cur_voice:isPlaying() then script_next() end end,
    function() scene_launch('home') end,
}
scr_friend = {
    function() chat('Fine, I\'ll be your friend.',arska,'friend') end,
}

function cafe_collect(obj)
    if obj.id=='cake' then 
        if not scr_cakeget.seen then script_start(scr_cakeget)
        elseif not scr_cakeget2.seen then script_start(scr_cakeget2)
        else script_start(scr_cakeget3) end
    end
    if obj==arska then script_start(scr_friend) end
    if obj==touko then script_start(scr_selfie) end
end

function cafe_use(obj)
    if obj.id=='cake' then
        if flags.steal then script_start(scr_cantpay); flags.steal = false
        else script_start(scr_cakeadmire) end
    end
    if obj.id=='leaf' then 
        if flags.steal then script_start(scr_leafpay)
        else script_start(scr_leafadmire) end
    end
    if obj.id=='map' then script_start(scr_locatecafe) end
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
