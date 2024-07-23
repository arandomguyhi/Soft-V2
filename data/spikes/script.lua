function onCreate()
    triggerEvent('Alt Idle Animation', 'gf', '-alt')
	playAnim('gf', 'idle-alt', true)
end

function onSectionHit()
	if curSection == 80 then
		doTweenAlpha('sakuraFade', 'sakura', 1, crochet / 1000)
	end

	if curSection == 95 then
		doTweenAlpha('sakuraFade', 'sakura', 0.001, 2.93)
	end

	if curSection == 128 then
		if isStoryMode then
			runHaxeCode([[
				FlxTween.num(game.health, 0.001, 2.53, null, function(num) { game.health = num; });
			]])
		end

		--close(true)
	end
end
