function onSectionHit()
	if curSection == 87 then
		fadeoutTime = 22

		doTweenAlpha('dadFade', 'dad', 0, fadeoutTime)
		doTweenAlpha('iconFade', 'iconP2', 0, fadeoutTime)
		doTweenAlpha('auraFade', 'monsterAura', 0, fadeoutTime)

		for i = 0, 3 do
			noteTweenAlpha('strumFade' .. i, i, 0, fadeoutTime)
		end

		runHaxeCode([[
			FlxTween.num(game.health, 2, ]] .. fadeoutTime .. [[, null, function(num) { game.health = num; });
		]])

		close(true)
	end
end
