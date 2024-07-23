local curSelected = 0
local menuList = {'RESUME', 'RESTART', 'OPTIONS', 'EXIT'}
local isPenHere = false

luaDebugMode = true

local imagesToLoad = {'stripes', 'notebook', 'pencil'}
function onCreate()
	addHaxeLibrary('CustomSubstate', 'psychlua')
	addHaxeLibrary('OptionsState', 'options')
	addHaxeLibrary('MusicBeatState', 'backend')

	for i = 1,3 do precacheImage('menus/pause/'..imagesToLoad[i]) end
	--precacheImage('pauseArt/'..getVar('pauseArtChar'))
	precacheSound('soft-pause')
end

function onPause()
	openCustomSubstate('Pause_Soft', true)
	if not buildTarget == 'windows' then
		setPropertyFromClass('flixel.FlxG', 'mouse.visible', true)
	end
	return Function_Stop
end

function onCustomSubstateCreate(name)
	if name == 'Pause_Soft' then
		playSound('soft-pause', 1, 'softPause')
		playSound('scrollMenu')

		makeLuaSprite('blackBG', nil)
		makeGraphic('blackBG', screenWidth, screenHeight, '000000')
		setProperty('blackBG.antialiasing', false)
		insertToCustomSubstate('blackBG')
		setProperty('blackBG.alpha', 0.0001)
		doTweenAlpha('blackieTween', 'blackBG', 0.5, 0.4, 'quadInOut')

		makeLuaSprite('riscos', 'menus/pause/stripes')
		setProperty('riscos.antialiasing', false)
		insertToCustomSubstate('riscos')
		setProperty('riscos.alpha', 0.001)
		doTweenAlpha('risquinhes', 'riscos', 1, 0.4, 'quadInOut')

		makeLuaSprite('pauseArt', 'pauseArt/'..getVar('pauseArtChar'), 650, 50)
		scaleObject('pauseArt', 0.65, 0.65)
		updateHitbox('pauseArt')
		insertToCustomSubstate('pauseArt')

		local hasthething = string.find(songName, ' ')
		local songNamie = (hasthething and string.gsub(songName, ' ', '-'):lower() or (songName):lower())
		makeLuaSprite('songBox', 'songtags/'..songNamie, 675, 475)
		scaleObject('songBox', 0.65, 0.65)
		insertToCustomSubstate('songBox')

		makeAnimatedLuaSprite('notebook', 'menus/pause/notebook', 0, 100)
		addAnimationByPrefix('notebook', 'anim', 'notebook', 24, false)
		scaleObject('notebook', 0.675, 0.675)
		insertToCustomSubstate('notebook')

		makeAnimatedLuaSprite('pen', 'menus/pause/pencil')
		addAnimationByPrefix('pen', 'anim', 'pencil', 24, false)
		scaleObject('pen', 0.675, 0.675)
		insertToCustomSubstate('pen')
		setProperty('pen.alpha', 0.001)

		--android
		makeAnimatedLuaSprite('upButton', 'androidPad', 0, 505)
		addAnimationByPrefix('upButton', 'idle', 'up0', 24, false)
		addAnimationByPrefix('upButton', 'press', 'up2', 24, false)
		playAnim('upButton', 'idle', true)
		setProperty('upButton.color', getColorFromHex('B3FF5D'))
		scaleObject('upButton', 0.85, 0.85)
		insertToCustomSubstate('upButton')

		makeAnimatedLuaSprite('downButton', 'androidPad', 0, 610)
		addAnimationByPrefix('downButton', 'idle', 'down0', 24, false)
		addAnimationByPrefix('downButton', 'press', 'down2', 24, false)
		playAnim('downButton', 'idle', true)
		setProperty('downButton.color', getColorFromHex('D0D0FF'))
		scaleObject('downButton', 0.85, 0.85)
		insertToCustomSubstate('downButton')

		makeAnimatedLuaSprite('aButton', 'androidPad', 1170, 610)
		addAnimationByPrefix('aButton', 'idle', 'a0', 24, false)
		addAnimationByPrefix('aButton', 'press', 'a2', 24, false)
		playAnim('aButton', 'idle')
		setProperty('aButton.color', getColorFromHex('FFBFD4'))
		scaleObject('aButton', 0.85, 0.85)
		insertToCustomSubstate('aButton')

		if buildTarget == 'windows' then
			local items = {'upButton', 'downButton', 'aButton'}
			for i = 1,3 do setProperty(items[i]..'.visible', false) end
		end
	end
end

function onCustomSubstateCreatePost(name)
	if name == 'Pause_Soft' then
		makeLuaText('scorie', 'Score: '..score, getProperty('scorie.width'), 875, 30)
		setTextSize('scorie', 32)
		setTextFont('scorie', 'DK Inky Fingers.otf')
		setTextAlignment('scorie', 'center')
		setObjectCamera('scorie', 'other')
		runHaxeCode("CustomSubstate.instance.add(game.modchartTexts.get('scorie'));")

		setProperty('scorie.alpha', 0.001)
		startTween('scorieTween', 'scorie', {alpha = 1, y = getProperty('scorie.y')+5}, 0.4, {ease = 'quartInOut', startDelay = 0.8})
	end
end

function onCustomSubstateUpdate(name)
	if name == 'Pause_Soft' then
		setTextString('scorie', difficultyName..'\nScore: '..score)

		if keyJustPressed('up') or getMouseX('camOther') > getProperty('upButton.x') and getMouseY('camOther') > getProperty('upButton.y') and getMouseX('camOther') < getProperty('upButton.x') + getProperty('upButton.width') and getMouseY('camOther') < getProperty('upButton.y') + getProperty('upButton.height') and mouseReleased() then
			changeItem(-1)
			playAnim('upButton', 'press')
		elseif keyJustPressed('down') or getMouseX('camOther') > getProperty('downButton.x') and getMouseY('camOther') > getProperty('downButton.y') and getMouseX('camOther') < getProperty('downButton.x') + getProperty('downButton.width') and getMouseY('camOther') < getProperty('downButton.y') + getProperty('downButton.height') and mouseReleased() then
			playAnim('downButton', 'press')
			changeItem(1)
		end

		if getProperty('controls.ACCEPT') or getMouseX('camOther') > getProperty('aButton.x') and getMouseY('camOther') > getProperty('aButton.y') and getMouseX('camOther') < getProperty('aButton.x') + getProperty('aButton.width') and getMouseY('camOther') < getProperty('aButton.y') + getProperty('aButton.height') and mouseReleased() then
			if curSelected == 0 then
				closeCustomSubstate()
			elseif curSelected == 1 then
				restartSong()
			elseif curSelected == 2 then
				runHaxeCode([[
					MusicBeatState.switchState(new OptionsState());
					FlxG.autoPause = false;
					OptionsState.onPlayState = true;
				]])
			elseif curSelected == 3 then
				exitSong()
			end
			playAnim('aButton', 'press')
		end

		if getProperty('notebook.animation.curAnim.finished') then
			setProperty('pen.alpha', 1)
		end

		if curSelected == 0 then
			setProperty('pen.x', 380)
			setProperty('pen.y', 100)
		elseif curSelected == 1 then
			setProperty('pen.x', 430)
			setProperty('pen.y', 205)
		elseif curSelected == 2 then
			setProperty('pen.x', 380)
			setProperty('pen.y', 330)
		elseif curSelected == 3 then
			setProperty('pen.x', 310)
			setProperty('pen.y', 453)
		end
	end
end

function changeItem(change)
	playSound('scrollMenu')
	playAnim('pen', 'anim')

	curSelected = curSelected + change
	if curSelected >= #menuList then
		curSelected = 0
	elseif curSelected < 0 then
		curSelected = #menuList - 1
	end
end

function onSoundFinished(tag)
	if tag == 'softPause' then
		playSound('soft-pause', 1, 'softPause')
	end
end

function onCustomSubstateDestroy(name)
	if name == 'Pause_Soft' then
		stopSound('softPause')
		if not buildTarget == 'windows' then
			setPropertyFromClass('flixel.FlxG', 'mouse.visible', false)
		end
	end
end

function onDestroy()
	if not buildTarget == 'windows' then
		setPropertyFromClass('flixel.FlxG', 'mouse.visible', true)
	end
end