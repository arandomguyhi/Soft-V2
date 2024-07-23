local bgPath = 'misc/images/lagtrain/'

function onCreate()
	makeLuaSprite('train', bgPath..'bg', 0, 0)
	addLuaSprite('train')

	makeLuaSprite('light', bgPath..'light', 0, 0)
	addLuaSprite('light', true)

	setProperty("camGame.bgColor", getColorFromHex('FFFFFF'))
end

function onCreatePost()
	setObjectCamera('comboGroup', 'game')
	setProperty('comboGroup.x', 200)
	setProperty('comboGroup.y', 100)
end

local lagtrain = {'train', 'light'}
function onEvent(name, value1, value2)
	if name == 'Lagtrain Stage Visibility' then
		for i = 1,2 do
			setProperty(lagtrain[i]..'.alpha', (value1 == 'false' and 0.001 or 1))
			setProperty('boyfriend.alpha', (value1 == 'false' and 0.001 or 1))
			setProperty('dad.alpha', (value1 == 'false' and 0.001 or 1))
			for i = 0,4 do setProperty('sven'..i..'.alpha', 0.001) setProperty('grace'..i..'.alpha', 0.001) end
		end
	end
end

function onGameOver()
	setProperty("camGame.bgColor", getColorFromHex('000000'))
end

function onDestroy()
	setProperty("camGame.bgColor", getColorFromHex('000000'))
end