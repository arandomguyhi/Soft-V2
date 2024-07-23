local bgLimo = 'weeks/week4/images/limo/'
local bgHench = 'weeks/week4/images/henchmen/'

local fastCarCanDrive = true

function onCreate()
	makeLuaSprite('skyBG', bgLimo..'limoSunset', -900, -550)
	setScrollFactor('skyBG', 0.1, 0.1)
	addLuaSprite('skyBG')

	makeAnimatedLuaSprite('bgLimo', bgLimo..'bgLimo', -150, 480)
	addAnimationByPrefix('bgLimo', 'idle', 'BG limo', 24, true)
	setScrollFactor('bgLimo', 0.4, 0.4)
	addLuaSprite('bgLimo')

	--henchemens
	makeAnimatedLuaSprite('isthatjimmyneutron', bgHench..'ThisGuyIsTotallyJimmyTrustMe', 230, 235)
	addAnimationByPrefix('isthatjimmyneutron', 'happy', 'SH1 Happ', 24, false)
	addAnimationByPrefix('isthatjimmyneutron', 'serious', 'SH1 Con', 24, false)
	addAnimationByPrefix('isthatjimmyneutron', 'angry', 'SH1 Angy', 24, false)
	setScrollFactor('isthatjimmyneutron', 0.4, 0.4)
	addLuaSprite('isthatjimmyneutron')

	makeAnimatedLuaSprite('hench3thatisthe2', bgHench..'Soft_Hench_3', 550, 100)
	addAnimationByPrefix('hench3thatisthe2', 'happy', 'SH3 Happ', 24, false)
	addAnimationByPrefix('hench3thatisthe2', 'serious', 'SH3 Con', 24, false)
	addAnimationByPrefix('hench3thatisthe2', 'angry', 'SH3 Angy', 24, false)
	setScrollFactor('hench3thatisthe2', 0.4, 0.4)
	addLuaSprite('hench3thatisthe2')

	makeAnimatedLuaSprite('hench2thatisthe3', bgHench..'Soft_Hench_2', 950, 180)
	addAnimationByPrefix('hench2thatisthe3', 'happy', 'SH2 Happ', 24, false)
	addAnimationByPrefix('hench2thatisthe3', 'serious', 'SH2 Con', 24, false)
	addAnimationByPrefix('hench2thatisthe3', 'angry', 'SH2 Angy', 24, false)
	setScrollFactor('hench2thatisthe3', 0.4, 0.4)
	addLuaSprite('hench2thatisthe3')

	makeLuaSprite('fastCar', bgLimo..'fastCarLol', -300, 160)
	setProperty('fastCar.antialiasing', false)
	setObjectOrder('fastCar', getObjectOrder('dadGroup'))
	addLuaSprite('fastCar')

	makeAnimatedLuaSprite('limo', bgLimo..'limoDrive', -120, 550)
	addAnimationByPrefix('limo', 'idle', 'Limo stage-idle', 24, true)
	setObjectOrder('limo', getObjectOrder('dadGroup'))
	addLuaSprite('limo')
end

function onCreatePost()
	setScrollFactor('gf', 0.4, 0.4)
	scaleObject('gf', 0.6, 0.6)
	setProperty('gf.x', 420)
	setProperty('gf.y', 190)

	setObjectCamera('comboGroup', 'game')
	setProperty('comboGroup.x', 300)
	setProperty('comboGroup.y', 100)

	local moveObjects = {'bgLimo', 'isthatjimmyneutron', 'hench3thatisthe2', 'hench2thatisthe3', 'gf'}
	for i = 1,#moveObjects do
		startTween('limoMoveTween'..i, moveObjects[i], {x = getProperty(moveObjects[i]..'.x')-100}, 5, {type = 'pingpong', ease = 'sineInOut'})
	end

	resetFastCar()
end

function onUpdate(elapsed) setVar('elapsed', elapsed) end

local henchAnim = {{'Intuition', 'happy'}, {'Catwalk', 'serious'}, {'Spotlight', 'angry'}}
local SHs = {'isthatjimmyneutron', 'hench3thatisthe2', 'hench2thatisthe3'}
function onBeatHit()
	if curBeat % 2 == 0 then
		for i = 1,3 do
			playAnim(SHs[i], (songName == henchAnim[i][1] and henchAnim[i][2] or 'serious'))
		end
	end

	if getRandomBool(10) and fastCarCanDrive then
		fastCarDrive()
	end
end

function resetFastCar()
	setProperty('fastCar.x', -12600)
	setProperty('fastCar.y', getRandomInt(140, 250))
	setProperty('fastCar.velocity.x', 0)
	fastCarCanDrive = true
end

function fastCarDrive()
	playSound('carPass'..getRandomInt(0,1), 0.7)

	setProperty('fastCar.velocity.x', (getRandomInt(170, 220) / getVar('elapsed')) * 3)
	fastCarCanDrive = false
	runTimer('resetCar', 2)
end

function onTimerCompleted(t)
	if t == 'resetCar' then
		resetFastCar()
	end
end