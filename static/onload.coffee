$ ->
	previewHeight = 30
	$('.lightbox').css('visibility', 'visible')
	
	_.each $('.card_stack'), (stack) ->
		_.each $(stack).children(), (child, i, list) ->
			$(child).css 'top', i * previewHeight + 'px'
			# $(child).css 'left', $(child).position().left + i * leftOffset + 'px'
# 			extraHeight = parseInt( $(child).css('height'), 10 ) - (previewHeight - 10)
# console.log extraHeight
	
	###
	previewHeight = 22
	leftOffset = 5
	
	
		 	
		 	
		 	$(child).hover (inEvent) ->
		 		for previous in list[i+1..]
		 			$(previous).css 'top', parseInt( $(previous).css('top'), 10 ) + extraHeight + 'px'
		 	, (outEvent) ->
		 		for previous in list[i+1..]
		 			$(previous).css 'top', parseInt( $(previous).css('top'), 10 ) - extraHeight + 'px'
		 	###
	
	# $('#dotscard').dotdotdot({})
	# $('.card').dotdotdot({})