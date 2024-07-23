local bgPath = 'weeks/week2/images/'
function onCreate()
    makeLuaSprite('background', bgPath..'bg', -700, -300)
    setProperty('background.antialiasing', false)
    addLuaSprite('background')

    makeLuaSprite('light', bgPath..'light', -300, -300) -- nao ta 100% mas fodase ninguem liga
    setProperty('light.antialiasing', false)
    addLuaSprite('light', true)
end

function onCreatePost()
    setObjectCamera('comboGroup', 'game')
    setProperty('comboGroup.x', -100)
    setProperty('comboGroup.y', 100)
end