-- these contain functions run once per frame
-- use script_next() to move on
scr_hello = {
    --function() if t-sc_t>=40 then script_next() end end,
    function() brace_interrupt(); waitclick() end,
    function() appear(touko) end,
    function() chat('Hmm jaahas! Today I shall collect the entire world!') end,
    function() chat('I will be respected and remembered!'); if t-sc_t==0 then flags.leafmove = true end end,
    function() chat('Truly I am the greatest!'); if not flags.leafmove then flags.leafmove = true end end,
}
scr_leaf3 = {
    function() brace_interrupt(); chat('Alright, I\'ve collected the whole forest.') end,
    function() chat('I\'m overworked! Better head home...........') end,
    function() waitsoft(160) end,
    function() chat('Uuh but how??') end,
    function() appear(mumina) end,
    function() chat('Need a ride?',mumina) end,
    function() chat('How much will it cost?') end,
    function() chat('I don\'t knooooow how much',mumina) end,
    function() chat('I don\'t really do numbers',mumina) end,
    function() chat('But just flash some kinda ticket',mumina) end,
    function() waithard(300) end,
    function() chat('You can också pay in nature',mumina) end,
    function() chat('I will ponder the deep meaning behind your words......') end,
}
scr_leaf1 = {
    function() chat('Such an arduous quest... but I\'ve finally found it.') end,
    function() chat('A leaf that might unlock my hidden potential..........') end,
}
scr_leaf2 = {
    function() chat('Quite the house of leaves you\'re building here.') end,
    function() chat('Would be a shame if someone blew on it.............') end,
}
scr_leafadmire = {
    function() chat('Truly, it is the child of a tree.') end,
}
scr_selfie = {
    function() chat('lmao now I\'m in my own inventory') end,
    function() chat('uuuuuhhh how do I get out actually hmm jaahas............') end,
}
scr_selfie2 = {
    function() chat('Fine, I\'ll put myself back.') end,
    function() deposit(touko) end,
}

function forest_collect(obj)
    if obj.id=='leaf' then 
        if not scr_selfie.seen then
            if not scr_leaf1.seen then script_start(scr_leaf1)
            elseif not scr_leaf2.seen then script_start(scr_leaf2)
            else script_start(scr_leaf3) end
        end
    end
    if obj==touko then script_start(scr_selfie) end
end

function forest_use(obj)
    if obj.id=='leaf' then
        script_start(scr_leafadmire)
    end
    if obj==touko then script_start(scr_selfie2) end
end

function forest_reset()
    bg_img = forest_bg

    scene = {touko,leaf1,leaf2,leaf3,mumina,luxus,banger}

    touko.x,touko.y = 0,sh-touko.img:getHeight()/2
    touko.x = touko.x-touko.img:getWidth()/2-20

    mumina.x,mumina.y = sw+20,sh-400-mumina.img:getHeight()/2+150
    
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
    leaf1.bx = leaf1.bx - 1.5; leaf1.x = leaf1.bx + sin(t*0.02)*125
    leaf2.bx = leaf2.bx - 1.5; leaf2.x = leaf2.bx + sin(t*0.021)*120
    leaf3.bx = leaf3.bx - 1.5; leaf3.x = leaf3.bx + sin(t*0.038)*135
    leaf1.by = leaf1.by + 1.15; leaf1.y = leaf1.by + sin(t*0.012)*40
    leaf2.by = leaf2.by + 1.15; leaf2.y = leaf2.by + sin(t*0.014)*42
    leaf3.by = leaf3.by + 1.15; leaf3.y = leaf3.by + sin(t*0.024)*36
end