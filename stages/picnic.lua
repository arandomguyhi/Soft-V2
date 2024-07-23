local bgPath = 'weeks/week6/images/'

function onCreate()
	x = -290 y = -255

	makeLuaSprite('background', bgPath..'bg', x, y)
	scaleObject('background', 1.1, 1.1)
	addLuaSprite('background')

	makeLuaSprite('backChars', bgPath..'cameos/red', 1800, 50)
	addLuaSprite('backChars')

	makeLuaSprite('ground', bgPath..'foreground', x, y)
	scaleObject('ground', 1.1, 1.1)
	addLuaSprite('ground')

	makeAnimatedLuaSprite('sakura', bgPath..'sakura', 0, 0)
	addAnimationByPrefix('sakura', 'idle', 'sakura', 24, true)
	setObjectCamera('sakura', 'hud')
	addLuaSprite('sakura')
	setProperty('sakura.alpha', 0.001)
end

function onCreatePost()
	setObjectCamera('comboGroup', 'game')
	setProperty('comboGroup.x', 200)
	setProperty('comboGroup.y', 100)

	startTween('cimaebaixo', 'backChars', {y = getProperty('backChars.y')+15}, 0.5, {type = 'pingpong', ease = 'quartIn'})
end

local isWalking = false
function onBeatHit()
	if curBeat % 4 == 0 and getRandomBool(50) and not isWalking then
		walkChars()
	end
end

local allChars = {'cj_ruby', 'garcello_annie', 'goku', 'kou_gsu', 'red', 'sonic_exe', 'sunday_carol', 'sweet_sour', 'torrent_bf'}
function walkChars()
	setProperty('backChars.x', 1800)

	loadGraphic('backChars', bgPath..'cameos/'..allChars[getRandomInt(1,#allChars)], false)
	doTweenX('backCharWalk', 'backChars', -1000, 25)
	isWalking = true
end

function onTweenCompleted(tag)
	if tag == 'backCharWalk' then
		isWalking = false
	end
end