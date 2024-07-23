function onSectionHit()
	if curSection == 24 then
		setProperty('sakura.alpha', 1)
		cameraFlash('camGame', 'ffffff', 0.75)
	end

	if curSection == 40 then
		doTweenAlpha('sakuraFade', 'sakura', 0.001, 2.93)
	end

	if curSection == 72 then
		doTweenAlpha('sakuraFade', 'sakura', 1, crochet / 1000)
	end

	if curSection == 88 then
		doTweenAlpha('sakuraFade', 'sakura', 0.001, 2.93)
		--close(true)
	end
end
