local bgPath = 'weeks/week5/images/normal/'
local crowdPath = 'weeks/week5/images/normal/bg_chars/'

function onCreate()
	makeLuaSprite('buildings', bgPath..'back buildings', -650, -300)
	setProperty('buildings.antialiasing', false)
	addLuaSprite('buildings')

	makeLuaSprite('floor', bgPath..'floor', -1300, -300)
	addLuaSprite('floor')

	makeLuaSprite('leftBuild', bgPath..'left building', -1300, -300)
	setProperty('leftBuild.antialiasing', false)
	addLuaSprite('leftBuild')

	makeLuaSprite('rightBuild', bgPath..'right building', 500, -300)
	setProperty('rightBuild.antialiasing', false)
	addLuaSprite('rightBuild')

	makeAnimatedLuaSprite('leftCrowd', crowdPath..'Left_Bop', -1195, 0)
	addAnimationByPrefix('leftCrowd', 'happy', 'Left Side Norm', 24, false)
	addAnimationByPrefix('leftCrowd', 'con', 'Left Side Con', 24, false)
	playAnim('leftCrowd', (songName == 'Faithful' and 'happy' or 'con'))
	scaleObject('leftCrowd', 0.7, 0.7)
	addLuaSprite('leftCrowd')

	makeAnimatedLuaSprite('rightCrowd', crowdPath..'Right_Bop', 340, 0)
	addAnimationByPrefix('rightCrowd', 'happy', 'Right Side Norm', 24, false)
	addAnimationByPrefix('rightCrowd', 'con', 'Right Side Con', 24, false)
	playAnim('rightCrowd', (songName == 'Faithful' and 'happy' or 'con'))
	scaleObject('rightCrowd', 0.7, 0.7)
	addLuaSprite('rightCrowd')

	makeLuaSprite('ribbon', bgPath..'ribbon', -1300, 175)
	setProperty('ribbon.antialiasing', false)
	addLuaSprite('ribbon')

	makeLuaSprite('sign', bgPath..'caution sign', -825, 370)
	addLuaSprite('sign')

	makeLuaSprite('chrismaTree', bgPath..'tree', -500, -300)
	addLuaSprite('chrismaTree')

	makeLuaSprite('snowyPico', bgPath..'snow pico yeah yeah snow pico uh', 675, 290)
	addLuaSprite('snowyPico')

	createInstance('xmasMother', 'objects.Character', {-578, 130, (songName == 'Faithful' and 'mother-xmas' or 'mother-xmas-2'), false})
	addInstance('xmasMother', true)
end

function onCreatePost()
	setObjectCamera('comboGroup', 'game')
	setProperty('comboGroup.x', -500)
	setProperty('comboGroup.y', 100)
end

function onBeatHit()
	if curBeat % 2 == 0 and not stringStartsWith(getProperty('xmasMother.animation.name'), 'sing') then
		callMethod('xmasMother.dance', {''})
	end
end

function opponentNoteHit(id, noteData, noteType, isSustainNote)
	if noteType == 'Alt Animation' or altAnim then
		playAnim('xmasMother', getProperty('singAnimations')[noteData+1], true)
		setProperty('xmasMother.holdTimer', 0)
	end
end

function onStepHit()
	playAnim('leftCrowd', (songName == 'Faithful' and 'happy' or 'con'))
	playAnim('rightCrowd', (songName == 'Faithful' and 'happy' or 'con'))
end