-- these contain functions run once per frame
-- use script_next() to move on
scr_hello = {
    function() brace_interrupt(); waithard(40) end,
    function() appear(touko) end,
    function() chat('Hmm jaahas! Today I shall collect the entire world!',touko,'collect') end,
    function() if t-sc_t==0 then flags.leafmove = true end; chat('I will be respected and remembered!',touko,'respected') end,
    function() chat('Indeed I am the greatest!',touko,'i am the greatest') end,
}
scr_allleaf = {
    function() brace_interrupt(); chat('Alright, I\'ve collected the whole forest.',touko,'collected the whole forest') end,
    function() chat('I\'m overworked! Better get home...........',touko,'overworked') end,
    function() waitsoft(160) end,
    function() chat('Uuh but how??',touko,'uhh but how') end,
    function() appear(mumina) end,
    function() chat('Need a ride?',mumina,'need a ride') end,
    function() chat('How much will it cost.',touko,'how much will it cost') end,
    function() chat('I don\'t knooooow how much',mumina,'don\'t know how much') end,
    function() chat('Cause I don\'t really do numbers',mumina,'don\'t really do numbers') end,
    function() if t-sc_t==0 then flags.ticket = true end; chat('But just flash some kinda ticket',mumina,'flash some kinda ticket') end,
    --function() waithard(400) end,
    -- offer something here or face madness
    --function() chat('You can också pay in nature',mumina) end,
    --function() chat('I will ponder the deep meaning behind your words......') end,
}
scr_noleaf = {
    function() brace_interrupt(); if t-sc_t==0 then luxus.id='???' end; chat('Nooo don\'t let the leaves go to waste',luxus) end,
    function() if t-sc_t==0 then line.cur='' end; appear(luxus) end,
    function() if t-sc_t==0 then luxus.id='Luxus' end; chat('I need to sample their rustling for my banger',luxus) end,
}
scr_leaf1 = {
    function() chat('Such an arduous quest... but I\'ve finally found it.',touko,'arduous quest') end,
    function() chat('A leaf that might unlock my hidden potential..........',touko,'hidden potential') end,
}
scr_leaf2 = {
    function() chat('Quite the house of leaves you\'re building here.',touko,'house of leaves') end,
    function() chat('Would be a shame if someone blew on it.............',touko,'would be a shame') end,
}
scr_leafadmire = {
    function() chat('The tree doesn\'t fall far from the leaf. I think.',touko,'tree doesn\'t fall') end,
}
scr_ticket = {
    function() brace_interrupt(); leaf1.x=sw+20; deposit(leaf1) end,
    function() chat('Yup, looks fine to me. Welcome aboard',mumina,'welcome aboard') end,
    function() touko.imgdata = touko_basic.imgdata; touko.img = touko_basic.img; script_next() end,
    function() script_start(scr_ikuso) end,
}
scr_ticketbent = {
    function() brace_interrupt(); leaf2.x=sw+20; deposit(leaf2) end,
    function() chat('Umm it seems a little bit bent.',mumina,'little bit bent') end,
    function() chat('I can work with that. However, can you?',mumina,'i can work with that') end,
    function() touko.imgdata = touko_bent.imgdata; touko.img = touko_bent.img; script_next() end,
    function() chat('Hmm jaahas so this is the new shape of my life............',touko,'new shape of my life') end,
    function() script_start(scr_ikuso) end,
}
scr_ticketsmol = {
    function() brace_interrupt(); leaf3.x=sw+20; deposit(leaf3) end,
    function() chat('It is very smol. Just like you now',mumina,'it is very smol') end,
    function() touko.imgdata = touko_smol.imgdata; touko.img = touko_smol.img; touko.y = sh-touko.img:getHeight()/2; script_next(); end,
    function() chat('You are indeed correct I am very smol.',touko,'i am very smol') end,
    function() chat('Note however that I am very bigg.',mumina,'i am very bigg') end,
    function() chat('Yes and very wise too',touko,'very wise too') end,
    function() script_start(scr_ikuso) end,
}
scr_ikuso = {
    function() brace_interrupt(); chat('Alright, shall we go?',mumina,'shall we go') end,
    -- hop on Mumina
    -- ride into the sunset
    function() scene_launch('home') end,
}
scr_worthless = {
    function() chat('That is worthless to a navigator.',mumina,'worthless') end,
}
scr_pickmumina = {
    function() chat('I thought I was supposed to give YOU a ride.',mumina,'give you a ride') end,
}
scr_selfie = {
    function() chat('lmao now I\'m in my own inventory',touko,'in my own inventory') end,
    function() chat('uuuuuhhh how do I get out actually hmm jaahas............',touko,'how do i get out actually') end,
}
scr_selfie2 = {
    function() chat('Fine, I\'ll put myself back.',touko,'fine i\'ll put myself back') end,
    function() deposit(touko) end,
}

function forest_collect(obj)
    if obj.id=='leaf' then 
        if not scr_leaf1.seen then script_start(scr_leaf1)
        elseif not scr_leaf2.seen then script_start(scr_leaf2)
        else flags.leafmove = false; script_start(scr_allleaf) end
    end

    if obj==mumina then script_start(scr_pickmumina) end
    if obj==touko then script_start(scr_selfie) end
end

function forest_use(obj)
    if not flags.ticket then
        if obj.id=='leaf' then
            script_start(scr_leafadmire)
        end
    else 
        if obj==leaf1 then script_start(scr_ticket); flags.ticket = false end
        if obj==leaf2 then script_start(scr_ticketbent); flags.ticket = false end
        if obj==leaf3 then script_start(scr_ticketsmol); flags.ticket = false end
        if obj.id=='map' then script_start(scr_worthless) end
        if obj==banger then end
        if obj==luxus then end
        if obj==mumina then end
        if obj==touko then end
        -- if not any of these then bring up a bonus video................................................
    end

    if obj==touko then script_start(scr_selfie2) end
end

function forest_reset()
    bg_img = forest_bg

    scene = {touko,leaf1,leaf2,leaf3,mumina,luxus,banger}

    touko.x,touko.y = 0,sh-touko.img:getHeight()/2
    touko.x = touko.x-touko.img:getWidth()/2-20

    mumina.x,mumina.y = sw+20,sh-400-mumina.img:getHeight()/2+150

    luxus.x,luxus.y = sw+20,sh-400-luxus.img:getHeight()/2+150
    
    banger.x,banger.y = sw+20,0

    leaf1.x,leaf1.y = 400+50,500-200-80-20
    leaf2.x,leaf2.y = 700+50,250-100-80-20
    leaf3.x,leaf3.y = 700+50+60,250-100-80-20+80

    leaf1.x = leaf1.x+500; leaf1.y = leaf1.y-450
    leaf2.x = leaf2.x+500; leaf2.y = leaf2.y-450
    leaf3.x = leaf3.x+500; leaf3.y = leaf3.y-450

    leaf1.bx=leaf1.x;leaf2.bx=leaf2.x;leaf3.bx=leaf3.x;leaf1.by=leaf1.y;leaf2.by=leaf2.y;leaf3.by=leaf3.y

    script_collect = forest_collect
    script_use = forest_use

    script_start(scr_hello)
end

function leaf_move()
    if find(scene,leaf1) then
    leaf1.bx = leaf1.bx - 1.5; leaf1.x = leaf1.bx + sin(t*0.02)*125
    leaf1.by = leaf1.by + 1.15; leaf1.y = leaf1.by + sin(t*0.012)*40
    end
    if find(scene,leaf2) then
    leaf2.bx = leaf2.bx - 1.5; leaf2.x = leaf2.bx + sin(t*0.021)*120
    leaf2.by = leaf2.by + 1.15; leaf2.y = leaf2.by + sin(t*0.014)*42
    end
    if find(scene,leaf3) then
    leaf3.bx = leaf3.bx - 1.5; leaf3.x = leaf3.bx + sin(t*0.038)*135
    leaf3.by = leaf3.by + 1.15; leaf3.y = leaf3.by + sin(t*0.024)*36
    end

    if (not find(scene,leaf1) or leaf1.y>=sh) and
       (not find(scene,leaf2) or leaf2.y>=sh) and
       (not find(scene,leaf3) or leaf3.y>=sh) then
        --if leaf1.y>=sh and leaf2.y>=sh and leaf3.y>=sh then
            --script_start(scr_noleaf)
        --else
            script_start(scr_allleaf)
        --end
        flags.leafmove = false
    end
end