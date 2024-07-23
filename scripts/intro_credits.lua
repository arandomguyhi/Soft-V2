function onCreatePost()
    makeLuaSprite('cards', 'credit_card', -700, 200)
    setProperty('cards.antialiasing', false)
    setObjectCamera('cards', 'hud')
    addLuaSprite('cards', true)

    makeLuaText('songieName', 'Song: '..songName, getProperty('songieName.width'), 50-700, 250)
    setTextSize('songieName', 20)
    setTextFont('songieName', 'MochiyPopOne-Regular.ttf')
    addLuaText('songieName')

    makeLuaText('artistName', 'Artists: '..getVar('artists'), getProperty('artistName.width'), 50-700, 280)
    setTextSize('artistName', 20)
    setTextFont('artistName', 'MochiyPopOne-Regular.ttf')
    addLuaText('artistName')
end

function onSongStart()
    doTweenX('cardtween', 'cards', 0, 1, 'cubeIn')
    doTweenX('songie', 'songieName', 50, 1, 'cubeIn')
    doTweenX('artistTween', 'artistName', 50, 1, 'cubeIn')
    runTimer('getOut', 5)
end

function onTimerCompleted(tag)
    if tag == 'getOut' then
        doTweenX('cardtween2', 'cards', -700, 1, 'cubeOut')
        doTweenX('songie2', 'songieName', 50-700, 1, 'cubeOut')
        doTweenX('artistTween2', 'artistName', 50-700, 1, 'cubeOut')
    end
end