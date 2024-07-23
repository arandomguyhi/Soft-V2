-- train will be added later
local bgPath = 'weeks/week3/images/'

luaDebugMode = true
function onCreate()
	makeLuaSprite('city', bgPath..'bg', -300, -100)
	setScrollFactor('city', 0.95, 0.95)
	scaleObject('city', 1.5, 1.5)
	setProperty('city.antialiasing', false)
	addLuaSprite('city')

	makeLuaSprite('ground', bgPath..'foreground', -300, -100)
	scaleObject('ground', 1.5, 1.5)
	--setProperty('ground.antialiasing', false)
	addLuaSprite('ground')
end

function onCreatePost()
    setObjectCamera('comboGroup', 'game')
    setProperty('comboGroup.x', 0)
    setProperty('comboGroup.y', 250)
end