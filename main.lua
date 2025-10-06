lg = love.graphics
bg = lg.clear
fg = lg.setColor
sin = math.sin
rand = love.math.random

require 'asset' -- loads global entities and data.
require 'script' -- tools for progressing dialogue.
require 'dialogue' -- tools for showing dialogue.
require 'sprite' -- tools for clickable entities.
require 'state' -- love.update functions.
require 'misc' -- leftover functions.

require 'scene' -- general scene transition functions.
require 'scene-forest' -- starting area scripting.
require 'scene-home' -- hub area scripting.
require 'scene-cafe' -- a very silly place.
require 'scene-wild' -- possibly even sillier.

bg_col = {r=0.6-0.2,g=0.6-0.2,b=0.6-0.2}
main_canvas = lg.newCanvas(sw,sh)

scene_launch('forest') -- showtime.

function love.draw()
    lg.setCanvas(main_canvas)
        if not bg_img then bg(0.8-0.6,0.8-0.6,0.8-0.6,1.0)
        else lg.draw(bg_img,-120,-60) end

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