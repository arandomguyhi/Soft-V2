local bgPath = 'weeks/week2/images/EVIL/'
function onCreate()
    makeLuaSprite('void', bgPath..'void', -700, -300)
    setProperty('void.antialiasing', false)
    addLuaSprite('void')

    makeLuaSprite('background', bgPath..'bg', -700, -300)
    setProperty('background.antialiasing', false)
    addLuaSprite('background')

    makeLuaSprite('objs', bgPath..'objects', 0, 50)
    setProperty('objs.antialiasing', false)
    addLuaSprite('objs')

    makeLuaSprite('light', bgPath..'light', -700, -300) -- nao ta 100% mas fodase ninguem liga
    setProperty('light.antialiasing', false)
    addLuaSprite('light')

    makeLuaSprite('light2', 'weeks/week2/images/light', -300, -300)
    setProperty('light2.antialiasing', false)
    addLuaSprite('light2', true)

    makeAnimatedLuaSprite('aura', 'monsterAura', 0, 0)
    addAnimationByPrefix('aura', 'idle', 'aura', 24, true)
    setObjectCamera('aura', 'hud')
    setProperty('aura.antialiasing', false)
    addLuaSprite('aura')
end

function onCreatePost()
    setObjectCamera('comboGroup', 'game')
    setProperty('comboGroup.x', 300)
    setProperty('comboGroup.y', 100)
end