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

    -- i guess Luxus is filling in for Arska in the demo then.
    arska = {}
    imgsrc(arska,'luxus.png')
    fontsrc(arska,'Extra Snack.ttf')
    arska.id = 'Luxus'
    arska.col = {r=0.8-0.15,g=0.7-0.15,b=0.4-0.15-0.1}

    -- so sorry Bundi but you're still in the queue!
    --bundi = {}
    --imgsrc(bundi,'luxus.png')
    --fontsrc(bundi,'GELOMBANG.ttf')
    --bundi.id = 'Bundi'
    --bundi.col = {r=0.8-0.15,g=0.7-0.15,b=0.6-0.15-0.1}

    laine = {}
    imgsrc(laine,'luxus.png')
    fontsrc(laine,'Ponari.ttf')
    laine.id = 'Laine'
    laine.col = {r=0.8-0.15,g=0.9-0.15,b=0.6-0.15-0.1}

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
        imgsrc(cake,string.format('cake-%d.png',i))
    end

    map_forest = {id='map'}
    imgsrc(map_forest,'map-forest.png')

    map_cafe = {id='map'}
    imgsrc(map_cafe,'map-cafe.png')

    map_cafe.homex = sw-map_cafe.img:getWidth()/2; map_cafe.homey = sh-200-40-map_cafe.img:getHeight()/2
    map_forest.homex = map_cafe.homex-map_forest.img:getWidth()/2; map_forest.homey = sh-200-40-map_forest.img:getHeight()/2

    touko_basic = {}
    imgsrc(touko_basic,'touko.png')    
    touko_smol = {}
    imgsrc(touko_smol,'touko-smol.png')
    touko_bent = {}
    imgsrc(touko_bent,'touko-bent.png')

    sounds = {}
    soundfiles = love.filesystem.getDirectoryItems('/assets/sounds/')
    for i,v in ipairs(soundfiles) do
        sounds[v] = love.audio.newSource('/assets/sounds/'..v,'static')
    end

    forest_bg = lg.newImage('/assets/photos/forest-1.png')    
    cafe_bg = lg.newImage('/assets/photos/cafe-1.png')
    home_bg = lg.newImage('/assets/photos/home-1.png')
    --wild_bg = lg.newImage('/assets/photos/wild-1.png')    
    -- not in demo
    --shower_bg = lg.newImage('/assets/photos/shower-1.jpg')    
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