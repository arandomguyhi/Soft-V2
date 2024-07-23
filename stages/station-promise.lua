function onCreate()
	makeLuaSprite('bg', 'misc/images/promise/bg', -312.05, -48)
	setScrollFactor('bg', 0.2, 0.2)
	addLuaSprite('bg')

	makeLuaSprite('cloud', 'misc/images/promise/cloud', -253.2, 6)
	setScrollFactor('cloud', 0.1, 0.1)
	addLuaSprite('cloud')

	makeAnimatedLuaSprite('train', 'misc/images/promise/train', -2200, 234)
	addAnimationByIndices('train', 'closed', 'train', '0', 0)
	addAnimationByIndices('train', 'open', 'train', '0,1,2,3,4,5,6,7', 24)
	addAnimationByIndices('train', 'close', 'train', '8,9,10,11,12,13,14', 24)
	addAnimationByIndices('train', 'opened', 'train', '8', 0)
	setScrollFactor('train', 0.6, 0.6)
	addLuaSprite('train')

	makeAnimatedLuaSprite('thugtext', 'misc/images/promise/thugtext', 400, 514)
	addAnimationByPrefix('thugtext', 'opentext', 'thugtext', 24, false)
	setProperty('thugtext.visible', false)
	addLuaSprite('thugtext', true)

	makeAnimatedLuaSprite('gaytext', 'misc/images/promise/gaytext', 678, 430)
	addAnimationByPrefix('gaytext', 'opentext', 'gaytext', 24, false)
	setProperty('gaytext.visible', false)
	addLuaSprite('gaytext', true)

	makeLuaSprite('station', 'misc/images/promise/station', -424.25, -159)
	setScrollFactor('station', 0.7, 0.7)
	addLuaSprite('station')

	runTimer('trainCome', 4)
end

function onTimerCompleted(t, l, ll)
	if t == 'trainCome' then
		setProperty('train.x', -2200)
		doTweenX('ee', 'train', -426.25, 4, 'sineOut')
		runTimer('trainOpen', 4)
	end

	if t == 'trainOpen' then
		playAnim('train', 'open')
		runTimer('trainClose', 10)
	end

	if t == 'trainClose' then
		playAnim('train', 'close')
		runTimer('trainRide', 4)
	end

	if t == 'trainRide' then
		doTweenX('ee', 'train', 1700, 4, 'sineIn')
		runTimer('trainCome', 20)
	end
end

function onEvent(n, v, b)
	if n == 'Object Play Animation' then
		if b == 'closetext' then
			if v == 'gaytext' then setProperty('gaytext.visible', false) end
			if v == 'thugtext' then setProperty('thugtext.visible', false) end
		end

		if b == 'opentext' then
			if v == 'gaytext' then setProperty('gaytext.visible', true) end
			if v == 'thugtext' then setProperty('thugtext.visible', true) end
		end
	end
end
