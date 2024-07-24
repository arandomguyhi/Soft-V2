-- bem simples
local rPath = 'menus/results/'
local results = {'score', 'misses', 'sick', 'good', 'bad', 'shit'}

local rankScore = {
	{'s', 1},
	{'a', 0.95},
	{'b', 0.85},
	{'c', 0.75},
	{'d', 0.6},
	{'f', 0.5}
}
local bleh = true

local imagesToLoad = {'background', 'topBar', 'title', 'backdrop', 'continueBar'}
local everything = {'rBack', 'topBar', 'songInfo', 'resultBar', 'rBackDrop', 'rArt', 'rRank', 'rankR', 'continue'}

luaDebugMode = true
function onCustomSubstateCreate(name)
	if name == 'result_screen' then
		playSound('soft-results', 1, 'softResult')

		setProperty('topBar.alpha', 1) setProperty('songInfo.alpha', 1) setProperty('resultBar.alpha', 1)
		setProperty('rBackDrop.alpha', 1)

		startTween('backtween', 'rBack', {alpha = 1}, 0.5, {ease = 'quartIn'})
		startTween('topbartween', 'topBar', {y = 0}, 0.5, {startDelay = 0.5, ease = 'linear'})
		startTween('infotween', 'songInfo', {y = 8}, 0.5, {startDelay = 0.5, ease = 'linear'})
		startTween('resultbartween', 'resultBar', {x = 0}, 0.5, {startDelay = 0.5, ease = 'linear'})
		startTween('backdroptween', 'rBackDrop', {x = 0}, 0.5, {startDelay = 1, ease = 'linear', onComplete = 'onTweenCompleted'})

		for i = 1,#rankScore do
			loadGraphic('rankR', rPath..'rank/'..(getProperty('ratingPercent') <= rankScore[i][2] and rankScore[i][1] or 's'), false)
			loadGraphic('rArt', rPath..'art/ben/'..(getProperty('ratingPercent') <= rankScore[i][2] and rankScore[i][1] or 's'), false)
		end
	end
end

function onCreate()
	for i = 1, #imagesToLoad do precacheImage(rPath..imagesToLoad[i]) end
	precacheSound('soft-results')

	createInstance('rBack', 'flixel.addons.display.FlxBackdrop', {nil, 0x01})
    --callMethod('rBack.setPosition', {getProperty('dad.x'), getProperty('dad.y')+120})
    loadGraphic('rBack', rPath..'background', false)
	setObjectCamera('rBack', 'other')
    screenCenter('rBack', 'XY')
    setProperty('rBack.velocity.x', getProperty('rBack.velocity.x')-20)
    addInstance('rBack')

	makeLuaSprite('topBar', rPath..'topBar', 0, -100)
	setObjectCamera('topBar', 'other')
	scaleObject('topBar', 0.67, 0.67)
	screenCenter('topBar', 'X')
	addLuaSprite('topBar')

	makeLuaText('songInfo', songName..' ('..difficultyName..')', getProperty('songInfo.width'), 0, 8-100)
	setTextFont('songInfo', 'Motley Forces.ttf')
	setTextSize('songInfo', 55)
	setObjectCamera('songInfo', 'other')
	setProperty('songInfo.x', screenWidth-(getProperty('songInfo.width'))-10)
	addLuaText('songInfo')

	makeLuaSprite('resultBar', rPath..'title', -500, 15)
	setObjectCamera('resultBar', 'other')
	scaleObject('resultBar', 0.67, 0.67)
	addLuaSprite('resultBar')

	makeLuaSprite('rBackDrop', rPath..'backdrop', -450, 0)
	setObjectCamera('rBackDrop', 'other')
	scaleObject('rBackDrop', 0.67, 0.67)
	setObjectOrder('rBackDrop', getObjectOrder('topBar'))
	addLuaSprite('rBackDrop')

	for i = 1,#results do
		makeLuaSprite('result'..results[i], rPath..results[i], -330+i*10, 80+i*90)
		setObjectCamera('result'..results[i], 'other')
		scaleObject('result'..results[i], 0.67, 0.67)
		addLuaSprite('result'..results[i])
		setProperty('result'..results[i]..'.alpha', 0.001)

		makeLuaText('resultScore'..results[i], '92050', getProperty('resultScore'..results[i]..'.width'), 350+i*15, 90+i*90)
		setTextFont('resultScore'..results[i], 'Motley Forces.ttf')
		setTextSize('resultScore'..results[i], 85)
		setObjectCamera('resultScore'..results[i], 'other')
		addLuaText('resultScore'..results[i])
		setProperty('resultScore'..results[i]..'.alpha', 0.001)
	end

	makeLuaSprite('rArt', rPath..'art/ben/s', 640+700, 80)
	setObjectCamera('rArt', 'other')
	scaleObject('rArt', 0.67, 0.67)
	addLuaSprite('rArt')

	makeLuaSprite('rRank', rPath..'rank', 650+700, 80)
	setObjectCamera('rRank', 'other')
	scaleObject('rRank', 0.67, 0.67)
	addLuaSprite('rRank')

	makeLuaSprite('rankR', rPath..'rank/s', 1078, 100)
	setObjectCamera('rankR', 'other')
	scaleObject('rankR', 0.6, 0.6)
	addLuaSprite('rankR')

	makeLuaSprite('continue', rPath..'continueBar', 640+650, 670)
	setObjectCamera('continue', 'other')
	scaleObject('continue', 0.67, 0.67)
	addLuaSprite('continue')

	for i = 1,#everything do
		setProperty(everything[i]..'.alpha', 0.001)
	end
end

function onCustomSubstateUpdate(name)
	if name == 'result_screen' then
		if getProperty('controls.ACCEPT') then
			closeCustomSubstate()
			endSong()
		end

		setTextString('resultScorescore', score)
		setTextString('resultScoremisses', misses)
		setTextString('resultScoresick', getProperty('ratingsData[0].hits'))
		setTextString('resultScoregood', getProperty('ratingsData[1].hits'))
		setTextString('resultScorebad', getProperty('ratingsData[2].hits'))
		setTextString('resultScoreshit', getProperty('ratingsData[3].hits'))
	end
end

if not isStoryMode then
function onEndSong()
	if bleh then
		bleh = false
		openCustomSubstate('result_screen')
		setProperty('inCutscene', true)
		return Function_Stop
	end
	return Function_Continue
end
end

function onCustomSubstateDestroy(name)
	if name == 'result_screen' then
		stopSound('softResult')
		setProperty('inCutscene', false)
	end
end

function onTweenCompleted(tag)
	if tag == 'backdroptween' then
		for i = 1,#results do
			setProperty('result'..results[i]..'.alpha', 1)
			startTween('resultTween'..i, 'result'..results[i], {x = 10+i*10}, 0.5, {startDelay = 0.2*i, ease = 'smoothlinear', onComplete = 'onTweenCompleted'})
		end
	end
	
	--for i = 1,#results do
		if tag == 'resultTween6' then
			runTimer('flash', 0.1)

			setProperty('rArt.alpha', 1) setProperty('rRank.alpha', 1) setProperty('continue.alpha', 1)

			startTween('arttween', 'rArt', {x = 640}, 0.5, {ease = 'linear', startDelay = 0.7})
			startTween('ranktween', 'rRank', {x = 650}, 0.5, {ease = 'linear', startDelay = 0.7})
			startTween('yourrank', 'rankR', {alpha = 1}, 0.5, {ease = 'linear', startDelay = 1.5})
			startTween('youcancontinue', 'continue', {x = 640}, 0.5, {ease = 'linear', startDelay = 4})
		end
	--end
end

function onTimerCompleted(tag)
	if tag == 'flash' then
		cameraFlash('camOther', 'ffffff', 0.75)
		for i = 1,#results do
			setProperty('resultScore'..results[i]..'.alpha', 1)
		end
	end
end

function onSoundFinished(tag)
	if tag == 'softResult' then
		playSound('soft-results', 1, 'softResult')
	end
end