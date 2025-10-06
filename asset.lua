function assetload()
    touko = {}
    imgsrc(touko,'touko.png')
    fontsrc(touko,'Super Joyful.ttf')
    touko.id = 'Touko'
    touko.col = {r=0.4-0.15,g=0.8-0.15,b=0.5-0.15}

    mumina = {}
    imgsrc(mumina,'mumina.png')
    fontsrc(mumina,'Bigbesty.ttf')
    mumina.id = 'Mumina'
    mumina.col = {r=0.8-0.15-0.1,g=0.4-0.15-0.1,b=0.7-0.15-0.1}

    luxus = {}
    imgsrc(luxus,'luxus.png')
    fontsrc(luxus,'Extra Snack.ttf')
    luxus.id = 'Luxus'
    luxus.col = {r=0.8-0.15,g=0.7-0.15,b=0.4-0.15-0.1}

    arska = {}
    imgsrc(arska,'luxus.png')
    fontsrc(arska,'Extra Snack.ttf')
    arska.id = 'Arska'
    arska.col = {r=0.8-0.15,g=0.7-0.15,b=0.4-0.15-0.1}

    banger = {}
    imgsrc(banger,'banger.png')

    for i=1,3 do
        local leaf = {id='leaf'}
        _G[string.format('leaf%d',i)] = leaf
        imgsrc(leaf,string.format('leaf-%d.png',i))
    end

    for i=1,3 do
        local cake = {id='cake'}
        _G[string.format('cake%d',i)] = cake
        imgsrc(cake,string.format('leaf-%d.png',i))
    end

    forest_bg = lg.newImage('/assets/photos/forest-1.jpg')    
    cafe_bg = lg.newImage('/assets/photos/cafe-1.jpg')    
    home_bg = lg.newImage('/assets/photos/home-1.jpg')    
    shower_bg = lg.newImage('/assets/photos/shower-1.jpg')    
end

function imgsrc(obj,src)
    -- the ImageData is needed for reading pixel colors.
    obj.imgdata = love.image.newImageData(string.format('/assets/sprites/%s',src))
    obj.img = lg.newImage(obj.imgdata)
end

function fontsrc(obj,src)
    obj.font = lg.newFont(string.format('/assets/fonts/%s',src),48+8+8)
    obj.fontsmol = lg.newFont(string.format('/assets/fonts/%s',src),28+12)
    obj.fontbig = lg.newFont(string.format('/assets/fonts/%s',src),142)
end

assetload()