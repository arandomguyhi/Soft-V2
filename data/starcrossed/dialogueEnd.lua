--this is not a full editable dialogue system, it was only made to fnf soft port.
local dialogueEnd = {
	{'How was that...?', '1end'}, --[[ bf ]]
	{'You did amazing, Blue!', '2end'}, --[[ pico ]]
	{'I knew you could do it.', '3end'}, --[[ pico ]]
	{'Thank you...', '4end'}, --[[ bf ]]
	{'Anytime.', '5end'}, --[[ pico ]]
	{'Though... We should probably get a move on before-', '6end'}, --[[ pico ]]
	{'Footsteps could be heard at the entrance of the alleyway, interrupting their conversation.', '7end'}, --[[ narrator ]]
	{'...?', ''}, --[[ pico ]]
	{'!!!', 'shock'}, --[[ bf ]]
}
local portraitShitEnd = { --[[ confusing, right? ]]
	{'bf', 'smile', true, true},
	{'pico', 'heart', false, true},
	{'pico', 'smug', false, false},
	{'bf', 'happycry', true, false},
	{'pico', 'smugsmile', false, false},
	{'pico', 'worry', false, false},
	{'narrator', 'closedtalk', false, true},
	{'pico', 'shock', true, true},
	{'bf', 'scared', true, true}
}
local textieEnd = 'blablabla'
local curDialogueEnd = 1

local allowEnd = false

local diaSoundsEnd = 'dialogue/sounds/'

luaDebugMode = true

if not isStoryMode then return end

setVar('dialogueEnded', false)
function onEndSong()
	if not allowEnd then
		allowEnd = true
		setVar('isOnDialogue', true)
		setProperty('inCutscene', true)

		startTween('backTweenEnd', 'diaBackground', {alpha = 1}, 0.001, {})
		startTween('boxTweenEnd', 'diaBox', {alpha = 1}, 0.001, {})
		startTween('txtTweenEnd', 'diaTxt', {alpha = 1}, 0.001, {})

		runTimer('start dia end', 0.003)
		
		return Function_Stop
	end
	return Function_Continue
end

function onTimerCompleted(t,l,ll)
	if t == 'start dia end' then
		startDiaEnd()
		playSound('dialogue/music/traffic', 0.8, 'diaSongEnd')
	end

	if t == 'add text end' then
		setTextString('diaTxt', string.sub(textieEnd, 0, (l - ll)))
	end

	if t == 'end dialogue' then
		setVar('isOnDialogue', false)
		setVar('dialogueEnded', true)
		stopSound('diaSongEnd')
	end
end

function onUpdate(el)
	if getPropertyFromClass('flixel.FlxG', 'keys.justPressed.ENTER') and getVar('isOnDialogue') then
		curDialogueEnd = curDialogueEnd + 1
		if curDialogueEnd > #dialogueEnd then
			startTween('backtweenEnd', 'diaBackground', {alpha = 0.001}, 1, {})
			startTween('boxtweenEnd', 'diaBox', {alpha = 0.001}, 1, {})
			startTween('texttweenEnd', 'diaTxt', {alpha = 0.001}, 1, {})
			startTween('portraittweenEnd', 'bf', {alpha = 0.001}, 1, {})

			runTimer('end dialogue', 1.05)
		else
			playSound(diaSoundsEnd..'advance')
			startDiaEnd()
		end
	end
end

function startDiaEnd()
	reloadTextEnd()
	runTimer('add text end', 0.04, string.len(textieEnd))

	playSound(diaSoundsEnd..'starcrossed/'..dialogueEnd[curDialogueEnd][2], 1, 'lyric'..curDialogueEnd)
	stopSound('lyricEnd'..curDialogueEnd-1)

	-- PORTRAIT SHITTTT
	local socoro = curDialogueEnd
	playAnim(portraitShitEnd[socoro][1], portraitShitEnd[socoro][2])
	setProperty(portraitShitEnd[socoro][1]..'.flipX', not portraitShitEnd[socoro][3])
	if curDialogueEnd > 1 then setProperty(portraitShitEnd[socoro-1][1]..'.alpha', 0.001) end

	if portraitShitEnd[socoro][4] == true then
		setProperty(portraitShitEnd[socoro][1]..'.x', (portraitShitEnd[socoro][3] == false and 145-600 or 850+600))
		startTween('tweenend'..portraitShitEnd[socoro][1], portraitShitEnd[socoro][1], {x = getProperty(portraitShitEnd[socoro][1]..'.x') + (portraitShitEnd[socoro][3] == false and 600 or -600), alpha = 1}, 0.5, {ease = 'linear'})
	else
		setProperty(portraitShitEnd[socoro][1]..'.alpha', 1)
		setProperty(portraitShitEnd[socoro][1]..'.x', (portraitShitEnd[socoro][3] == false and 145 or 850))
	end
	--end
end

function reloadTextEnd()
	textieEnd = dialogueEnd[curDialogueEnd][1]
	setTextString('diaTxt', '')
end

function onSoundFinished(tag)
	if tag == 'diaSongEnd' then
		playSound('dialogue/music/traffic', 0.8, 'diaSong')
	end
end