scr_enterwild = {
    function() scr_noleaf.seen=true; brace_interrupt(); appear(touko) end,
    function() chat('This hardly looks like a silly place.') end,
    function() if scr_noleaf.seen then script_start(scr_enterlaine) else script_start(scr_lostluxus) end end,
}
scr_lostluxus = {
    function() brace_interrupt(); appear(luxus) end,
    function() chat('Hnnng I dropped my banger and can\'t find it',luxus); waithard(70) end,
    function() chat('Hello.') end,
    function() chat('I dropped my banger and can\'t find it',luxus) end,
}
scr_ithappened = {
    function() chat('It happened because of me.') end,
    function() chat('Do you find it in your heart to ever forgive me?') end,
    function() chat('no',luxus) end,
    -- facezoom
    function() waithard(90) end,
    function() chat('then the wind will blow me away like the autumn leaves') end,
}
scr_enterlaine = {
    function() brace_interrupt(); if t-sc_t==0 then laine.id='???' end; chat('I figured you\'d say exactly that.',laine) end,
    function() if t-sc_t==0 then line.cur='' end; appear(laine) end,
    function() if t-sc_t==0 then laine.id='Laine' end; chat('Hmm jaahas........!',laine) end,
    function() chat('Hmm jaahas......................') end,
}

function wild_collect(obj)
    if obj==touko then script_start(scr_selfie) end
end

function wild_use(obj)
    if obj==touko then script_start(scr_selfie2) end
end

function wild_reset()
    bg_img = wild_bg

    scene = {touko,luxus,laine}

    touko.x,touko.y = 0,sh-touko.img:getHeight()/2
    touko.x = touko.x-touko.img:getWidth()/2-20

    luxus.x,luxus.y = sw+20,sh-400-luxus.img:getHeight()/2+150

    laine.x,laine.y = sw+20,sh-400-laine.img:getHeight()/2+150

    script_collect = wild_collect
    script_use = wild_use

    script_start(scr_enterwild)
end
