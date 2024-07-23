local bgPath = 'misc/images/bench/'

luaDebugMode = true
function onCreate()
	makeLuaSprite('back', bgPath..'bg', -100, -30)
	addLuaSprite('back')

	makeLuaSprite('city', bgPath..'city', -125, 160)
	addLuaSprite('city')

	makeLuaSprite('bench', bgPath..'bench', -200, 400)
	addLuaSprite('bench')
end

function onCreatePost() setObjectOrder('dadGroup', getObjectOrder('boyfriendGroup')+1) end

function onSongStart()
    setProperty('isCameraOnForcedPos', true)
end

function noteMiss(i, dont, need, these)
    if getProperty('dad.curCharacter') == 'pico-bench' then
        triggerEvent('Play Animation', 'bozo', 0)
    end
end