function script_run()
    local active = script.cur[script.i]
    if active then active()
    else 
        if script.anyway and not (script.cur==script.anyway) then
            -- an interruption script just ended, so return to what was interrupted.
            script_start(scr_anyway)
        else 
            line.cur=''
            if script.anyway and script.cur==script.anyway then
                -- we passed through a script that was expecting an interrupt.
                script.anyway.i = nil
                script.anyway = nil
            end
        end
    end
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
    --if scr==script.anyway then
        --script.anyway.i = nil
        --script.anyway = nil
    --end
    scr.seen = true
    sc_t = t
end

function script_next()
    script.i = script.i+1
    sc_t = t
    script_run()
end

function chat(ln,speaker)
    -- function to process a line of dialogue 
    -- called every frame while the line is active
    -- drawing happens in dialogue.lua/lineprint
    if not (ln==line.cur) then
        -- if the contents of the message 'ln' change,
        -- initialize another line.
        line.cur = ln
        line.i = 0; line.t = 0
        speaker = speaker or touko
        diagbox.speaker = speaker
        return
    end

    if click and not lastclick then
        -- hurry up line and move to next.
        love.update = freeform
        diagbox.w1 = 1; diagbox.w2 = 1
        if line.i<#line.cur+1 then line.i = #line.cur+1
        else script_next() end
        return
    end

    -- line.i can go past the line length
    -- because of an animation that's accounted for during drawing.
    if line.t%2==0 and diagbox.w1>0.5 then line.i = line.i+1 end

    line.t = line.t+1
end

function deposit(obj)
    -- helper function intended to be used at the end of inventory clicking scripts.
    table.remove(inventory,find(inventory,obj)); if #inventory>0 and inventory.i>#inventory then inventory.i=#inventory end; table.insert(scene,obj); obj.gone=false; script_next()
end

function brace_interrupt()
    -- to mark scripts as main quests
    if t-sc_t==0 then script.anyway = script.cur end
end

function waitsoft(delay)
    -- delay, can be hurried with clicking
    if t-sc_t==0 then line.cur='' end
    if (t-sc_t>=delay) or (t-sc_t>0 and click and not lastclick) then 
        script_next() 
    end 
end

function waithard(delay)
    -- mean delay
    if t-sc_t==0 then line.cur='' end
    if (t-sc_t>=delay) then
        script_next() 
    end 
end

-- a reusable script for returning to what was interrupted.
-- fun might ensue since this has a variable speaker
scr_anyway = {
    function() chat('Anyway.......',diagbox.speaker) end,
    function() script_start(script.anyway) end,
}