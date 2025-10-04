lg = love.graphics
bg = lg.clear
fg = lg.setColor

touko = {}
touko.img = lg.newImage('/assets/chars/touko.png')
touko.font = lg.newFont('/assets/fonts/Super Joyful.ttf',48+8+8)
leaf1 = {}
leaf1.img = lg.newImage('/assets/items/leaf-1.png')
leaf2 = {}
leaf2.img = lg.newImage('/assets/items/leaf-2.png')

main_canvas = lg.newCanvas(sw,sh)

t = 0
function love.update(dt)
    t = t+1
end

function love.draw()
    lg.setCanvas(main_canvas)
        bg(0.8-0.6,0.8-0.6,0.8-0.6,1.0)

        fg(0.6-0.2,0.6-0.2,0.6-0.2,1)
            lg.rectangle('fill',200,sh-200-40,800,200)
            lg.circle('fill',200+800,sh-200-40+200/2,200/2)
        fg(0.4-0.15,0.8-0.15,0.5-0.15)
            lg.setFont(touko.font)
            lg.print('Hmm jaahas! I\'ll make sure\nto collect the entire world!',
                     200+40+40+40,sh-200-40+20)

        fg(1,1,1,1)
            lg.draw(touko.img,0,sh-touko.img:getHeight()*0.5,0,0.5,0.5)
            lg.draw(leaf1.img,400+50,500-200-80,0,0.5,0.5)
            lg.draw(leaf2.img,700+50,250-100-80,0,0.5,0.5)

    lg.setCanvas()
        fg(1,1,1,1)
        lg.draw(main_canvas,0,0)
end