function onCreate()
    setProperty("camGame.bgColor", getColorFromHex('FFFFFF'))
end

function onGameOver()
    setProperty("camGame.bgColor", getColorFromHex('000000'))
end

function onDestroy()
    setProperty("camGame.bgColor", getColorFromHex('000000'))
end