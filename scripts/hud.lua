local totalHits = 0
local lastSection = false

luaDebugMode = true
function getHealthColor(arg)
    return rgbToHex(getProperty(arg..".healthColorArray[0]"), getProperty(arg..".healthColorArray[1]"), getProperty(arg..".healthColorArray[2]"));
end

function rgbToHex(r,g,b)
    return string.format("%02x%02x%02x", r, g, b)
end

function onCreatePost()
    for i = 0, getProperty('unspawnNotes.length')-1 do
	setPropertyFromGroup('unspawnNotes', i, 'noteSplashData.disabled', true)
    end

    setProperty('timeBar.leftBar.color', getColorFromHex(getHealthColor('dad'))) -- nao consegui fazer o gradient :c

    setProperty('healthBar.bg.visible', false)
    setProperty('healthBar.scale.x', getProperty('healthBar.scale.x')-0.0135) --vou fingir que não demorei 50 anos aqui
    setProperty('healthBar.scale.y', getProperty('healthBar.scale.y')-0.19)

    setTextFont('timeTxt', 'DK Inky Fingers.otf')
    setTextSize('timeTxt', 25)
    setTextFont('scoreTxt', 'MochiyPopOne-Regular.ttf')
    setTextSize('scoreTxt', 16)

    makeLuaSprite('HealthBar', 'healthBarNEW', getProperty('healthBar.x')-32.1, getProperty('healthBar.y')-43.4)
    setObjectCamera('HealthBar', 'hud')
    setObjectOrder('HealthBar', getObjectOrder('uiGroup'))
    addLuaSprite('HealthBar')

    makeAnimatedLuaSprite('noteCombo', 'comboMilestone', 150, 170)
    addAnimationByPrefix('noteCombo', 'anim', 'NOTE COMBO animation', 24, false)
    playAnim('noteCombo', 'anim')
    scaleObject('noteCombo', 0.7, 0.7)
    setObjectCamera('noteCombo', 'hud')
    setProperty('noteCombo.antialiasing', false)
    addLuaSprite('noteCombo')
    setProperty('noteCombo.alpha', 0.001)

    --numbers
    for i = 1,3 do
        makeAnimatedLuaSprite('noteComboNum'..i, 'comboMilestoneNumbers', 250+i*100, 430+i*-15) --250, 430
        for c = 0,9 do
            addAnimationByPrefix('noteComboNum'..i, c..' num', c..' light', 24, false) end
        setObjectCamera('noteComboNum'..i, 'hud')
        scaleObject('noteComboNum'..i, 0.7, 0.7)
        setProperty('noteComboNum'..i..'.antialiasing', false)
        addLuaSprite('noteComboNum'..i)
        setProperty('noteComboNum'..i..'.alpha', 0.001)
    end

    makeLuaSprite('3', '3', 0, 0)
    setProperty('3.antialiasing', false)
    screenCenter('3', 'XY')
    setObjectCamera('3', 'hud')
    addLuaSprite('3', true)
    setProperty('3.alpha', 0.001)
end

--got the combo num from semeone i forgo the name :fire:
function onUpdate()
    if lastSection ~= mustHitSection then
        lastSection = mustHitSection
        if not lastSection and totalHits > 0 then
            setProperty('noteCombo.alpha', 1)
            playAnim('noteCombo', 'anim')

            separatedHits = ''
            local combo = tostring(totalHits)
            for i = 1,3 do
                local num = string.sub(combo,i,i)
                if num ~= '' then
                    separatedHits = separatedHits..num
                else
                    separatedHits = ' '..separatedHits
                end
            end

            for i = 1,3 do
                local num = string.sub(separatedHits,i,i)
                if num ~= '' and num ~= ' ' then
                    setProperty('noteComboNum'..i..'.alpha', 1)
                    startTween('notenumtween'..i, 'noteComboNum'..i, {alpha = 1}, 0.05, {ease = 'cubeIn'})
                    playAnim('noteComboNum'..i, num..' num')
                    runTimer('somecarai', 0.8)
                end
            end
        end
    end

    setVar('SH', separatedHits)

    if getProperty('noteCombo.animation.curAnim.finished') then
        setProperty('noteCombo.alpha', 0.001) end
end

function onTimerCompleted(tag)
    if tag == 'somecarai' then
        for i = 1,3 do
            local num = string.sub(getVar('SH'),i,i)
            if num ~= '' and num ~= ' ' then
                startTween('notenumtweenout'..i, 'noteComboNum'..i, {alpha = 0.001}, 0.08, {startDelay = 0.05, ease = 'cubeOut'})
                playAnim('noteComboNum'..i, num..' num')
            end
        end
    end
end

--pretty cool way to do this
local countdowns = {
    {'Ready', '2'},
    {'Set', '1'},
}
function onCountdownTick(c)
    if c == 0 then
	    setProperty('3.alpha', 1)
	    setProperty('3.y', getProperty('3.y')+30)
	    doTweenAlpha('3count', '3', 0.001, crochet/1000, 'cubeInOut')
    end

    for i = 1, 2 do
        if c == i then
            loadGraphic('countdown'..countdowns[i][1], countdowns[i][2])
	        screenCenter('countdown'..countdowns[i][1], 'XY')
	        setProperty('countdown'..countdowns[i][1]..'.y', getProperty('countdown'..countdowns[i][1]..'.y')+30)
        end
    end
end

function goodNoteHit(_,_,_,s)
    if not s then totalHits = totalHits + 1 end
end

function noteMiss() totalHits = 0 end
function noteMissPress() totalHits = 0 end