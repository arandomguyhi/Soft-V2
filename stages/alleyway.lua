local bgPath = 'weeks/week1/images/'

function onCreate()
    makeLuaSprite('background', bgPath..'bg', -300, -80)
    setProperty('background.antialiasing', false)
    addLuaSprite('background')

    makeLuaSprite('box', bgPath..'boxes', 1300, 720)
    setProperty('box.antialiasing', false)
    addLuaSprite('box')
end

function onCreatePost()
    if songName == 'Starcrossed' then
        setProperty('gf.visible', false)
        setProperty('dad.x', getProperty('dad.x')+150)
        setProperty('dad.y', getProperty('dad.y')+40)
    end

    setObjectCamera('comboGroup', 'game')
    setProperty('comboGroup.x', 200)
    setProperty('comboGroup.y', 100)
end