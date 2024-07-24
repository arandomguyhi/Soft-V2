--this is not a full editable dialogue system, it was only made to fnf soft port.

local dialogue = { --[[ this table got a glow up in the ending dialogue script]]
	--[[ NARRATOR ]]
	'The city of stars...',
	'A place where the rich live lavishly...',
	'And the not-so-fortunate struggle to survive day by day.',
	'Two boys who have been on the run for two weeks are spotted dashing into an alleyway, as the sun begins to set over the skyline.',
	'Pico, a high school dropout and notorious graffiti artist...',
	'And Benjamin, a blue-haired boy with aspirations of becoming an artist...',
	'Both come to a halt, catching their breath.',

	--[[ now the scene ]]
	'That was close.', --[[ pico ]]
	'Do you think he saw us...?', --[[ bf ]]
	"I don’t think so.", --[[ pico ]]
	"This is the third time this week we’ve almost been caught.", --[[ pico ]]
	'I know...', --[[ bf ]]
	"With them plastering your face all over town, inevitably, someone’s eventually gonna catch onto us.", --[[ pico ]]
	'...', --[[ bf ]]
	'We both know the way they settle things, Ben. We need to be ready for it.', --[[ pico ]]
	"I told you running away wasn’t a good idea!", --[[ bf ]]
	"I can’t do this. What if-", --[[ bf ]]
	'Ben.', --[[ pico ]]
	"When he catches us, he’ll-", --[[ bf ]]
	"Hey. It’s going to be okay.", --[[ pico ]]
	"I’ve got your back every step of the way.", --[[ pico ]]
	'What do we do...?', --[[ bf ]]
	'How about we do a practice round?', --[[ pico ]]
	'Repeat after me.' --[[ pico ]]
}
local portraitShit = { --[[ confusing, right? ]]
	{'narrator', 'look', false, true},
	{'narrator', 'smile', false, false},
	{'narrator', 'closedtalk', false, false},
	{'narrator', 'talk', false, false},
	{'pico', 'neutral', false, true},
	{'bf', 'smile', true, true},
	{'narrator', 'look', false, false},
	{'pico', 'worry', false, true},
	{'bf', 'concerned', true, true},
	{'pico', 'neutral', false, false},
	{'pico', 'worry', false, false},
	{'bf', 'nervous', true, false},
	{'pico', 'worry', false, false},
	{'bf', 'nervous', true, false},
	{'pico', 'neutral', false, false},
	{'bf', 'concerned', true, false},
	{'bf', 'worried', true, false},
	{'pico', 'worry', false, false},
	{'bf', 'worried', true, false},
	{'pico', 'smug', false, false},
	{'pico', 'smugsmile', false, false},
	{'bf', 'concerned', true, false},
	{'pico', 'questioning', false, false},
	{'pico', 'neutral', false, false}
}
local textie = 'blablabla'
local curDialogue = 1

local allowStart = false
setVar('dialogue1end', false)

local diaSounds = 'dialogue/sounds/'
local imgPath = 'dialogue/images/'

luaDebugMode = true

if not isStoryMode then return end

setVar('isOnDialogue', false)

function onStartCountdown()
	if not allowStart then
		allowStart = true
		setProperty('inCutscene', true)

		runTimer('start dia', 1.1)
		
		return Function_Stop
	end
	return Function_Continue
end

function onCreatePost()
	makeLuaSprite('diaBackground', imgPath..'backgrounds/intro', 0, 0)
	setObjectCamera('diaBackground', 'hud')
	screenCenter('diaBackground', 'XY')
	addLuaSprite('diaBackground', true)

	-- the chars now
	local narratorAnims = {'closedsmile', 'closedtalk', 'look', 'smile', 'talk'}
	makeAnimatedLuaSprite('narrator', imgPath..'portraits/megablade', 145-600, 90)
	for i = 1,#narratorAnims do addAnimationByPrefix('narrator', narratorAnims[i], narratorAnims[i], 24, false) end
	setObjectCamera('narrator', 'hud')
	addLuaSprite('narrator', true)
	setProperty('narrator.alpha', 0.001)

	local picoAnims = {'smug', 'heart', 'smugsmile', 'neutral', 'worry', 'questioning', 'annoyed', 'bored', 'flustered', 'spray', 'shock'}
	makeAnimatedLuaSprite('pico', imgPath..'portraits/pico', 145-600, 120)
	for i = 1,#picoAnims do addAnimationByPrefix('pico', picoAnims[i], picoAnims[i], 24, false) end
	setObjectCamera('pico', 'hud')
	addLuaSprite('pico', true)
	setProperty('pico.alpha', 0.001)

	local bfAnims = {'hitit', 'smile', 'happy', 'happycry', 'slightsurprise', 'slightblush', 'concerned', 'confused', 'worried', 'scared', 'nervoussmile', 'annoyed', 'sweating', 'what', 'nervous', 'angrycry', 'terrified', 'uncomfortable'}
	makeAnimatedLuaSprite('bf', imgPath..'portraits/bf', 850+600, 140)
	for i = 1,#bfAnims do addAnimationByPrefix('bf', bfAnims[i], bfAnims[i], 24, false) end
	setObjectCamera('bf', 'hud')
	addLuaSprite('bf', true)
	setProperty('bf.alpha', 0.001)

	makeLuaSprite('diaBox', imgPath..'dialogueBox', 0, 0)
	setObjectCamera('diaBox', 'hud')
	screenCenter('diaBox', 'X')
	addLuaSprite('diaBox', true)
	setProperty('diaBox.y', screenHeight - getProperty('diaBox.height'))

	makeLuaText('diaTxt', '', screenWidth*0.55, 205, 480)
	setTextFont('diaTxt', 'DK Inky Fingers.otf')
	setTextColor('diaTxt', '000000')
	setTextBorder('diaTxt', 0, 0)
	setTextSize('diaTxt', 24)
	setTextAlignment('diaTxt', 'left')
	addLuaText('diaTxt')

	makeLuaText('pressEsc', 'Press BACK to skip', getProperty('pressEsc.width'), 10, screenHeight-30)
	setTextFont('pressEsc', 'DK Inky Fingers.otf')
	setTextSize('pressEsc', 16)
	setTextAlignment('pressEsc', 'left')
	addLuaText('pressEsc')
	setProperty('pressEsc.alpha', 0.001) startTween('backe', 'pressEsc', {alpha = 1}, 1, {startDelay = 2.5})
	startTween('backout', 'pressEsc', {alpha = 0.001}, 1, {startDelay = 15})

	makeLuaSprite('trans', nil)
	makeGraphic('trans', 1280, 720, '000000')
	setObjectCamera('trans', 'hud')
	screenCenter('trans', 'XY')
	addLuaSprite('trans', true)

	startTween('transTween', 'trans', {alpha = 0.001}, 1, {})
	startTween('backTween', 'diaBackground', {alpha = 1}, 1, {})
	startTween('boxTween', 'diaBox', {alpha = 1}, 1, {})
	startTween('txtTween', 'diaTxt', {alpha = 1}, 1, {})
end

local diaSong = ''
function onTimerCompleted(t,l,ll)
	if t == 'start dia' then
		startDia()
		playSound('dialogue/music/traffic', 0.8, 'diaSong')
	end

	if t == 'add text' then
		setTextString('diaTxt', string.sub(textie, 0, (l - ll)))
	end

	if t == 'start song' then
		startCountdown()
		stopSound('diaSong2')
		setVar('dialogue1end', true)

		loadGraphic('diaBackground', imgPath..'backgrounds/alleyway', false)
		screenCenter('diaBackground', 'XY')
	end
end

function onUpdate(el)
	if getVar('dialogue1end') then return end

	if getPropertyFromClass('flixel.FlxG', 'keys.justPressed.ENTER') then
		curDialogue = curDialogue + 1
		if curDialogue > table.maxn(dialogue) then
			endDialogue()
		else
			playSound(diaSounds..'advance')
			startDia()
		end
	end

	if getProperty('controls.BACK') then
		curDialogue = #dialogue +1
		endDialogue()
	end
end

function startDia()
	reloadText()
	runTimer('add text', 0.04, string.len(textie))

	playSound(diaSounds..'starcrossed/'..curDialogue, (curDialogue == 14 and 0.001 or 1), 'lyric'..curDialogue)
	stopSound('lyric'..curDialogue-1)

	if curDialogue == 8 then
		loadGraphic('diaBackground', imgPath..'backgrounds/alleyway', false)
		screenCenter('diaBackground', 'XY')
		stopSound('diaSong')
		playSound('dialogue/music/on-the-run', 0.7, 'diaSong2')
	end

	-- PORTRAIT SHITTTT
	local socor = curDialogue
	playAnim(portraitShit[socor][1], portraitShit[socor][2])
	setProperty(portraitShit[socor][1]..'.flipX', not portraitShit[socor][3])
	if curDialogue > 1 then setProperty(portraitShit[socor-1][1]..'.alpha', 0.001) end

	if portraitShit[socor][4] == true then
		setProperty(portraitShit[socor][1]..'.x', (portraitShit[socor][3] == false and 145-600 or 850+600))
		startTween('tween'..portraitShit[socor][1], portraitShit[socor][1], {x = getProperty(portraitShit[socor][1]..'.x') + (portraitShit[socor][3] == false and 600 or -600), alpha = 1}, 0.5, {ease = 'linear'})
	else
		setProperty(portraitShit[socor][1]..'.alpha', 1)
		setProperty(portraitShit[socor][1]..'.x', (portraitShit[socor][3] == false and 145 or 850))
	end

	--silhouette thing
	if curDialogue > 4 then
		setProperty(portraitShit[socor][1]..'.color', getColorFromHex('000000')) end
	if curDialogue > 6 then
		setProperty(portraitShit[socor][1]..'.color', getColorFromHex('ffffff')) end
	--end
end

function reloadText()
	textie = dialogue[curDialogue]
	setTextString('diaTxt', '')
end

function endDialogue()
	startTween('backtween', 'diaBackground', {alpha = 0.001}, 1, {})
	startTween('boxtween', 'diaBox', {alpha = 0.001}, 1, {})
	startTween('texttween', 'diaTxt', {alpha = 0.001}, 1, {})
	for i = 1,#dialogue do startTween('portraittween'..i, portraitShit[i][1], {alpha = 0.001}, 1, {}) end

	cancelTween('backe') cancelTween('backout')
	startTween('backout2', 'pressEsc', {alpha = 0.001}, 1, {})

	stopSound('lyric'..curDialogue)
	runTimer('start song', 1.05)
end

function onSoundFinished(tag)
	if tag == 'diaSong' then
		playSound('dialogue/music/traffic', 0.8, 'diaSong')
	elseif tag == 'diaSong2' then
		playSound('dialogue/music/on-the-run', 0.7, 'diaSong2')
	end
end