$ ->
	# $(document).scrollTop($(document).height())
	$('.lightbox').css('visibility', 'visible')
	window.onScroll(null, null, null, 0)
	# previewHeight = 20
	# _.each $('.card_stack'), (stack) ->
	# 	_.each $(stack).children(), (child, i, list) ->
	# 		$(child).css 'top', i * previewHeight + 'px'
			
			
			
	# window.onScroll()
	
	###
	previewHeight = 22
	leftOffset = 5
	
	_.each $('.card_stack'), (stack) ->
		 _.each $(stack).children(), (child, i, list) ->
		 	$(child).css 'top', i * previewHeight + 'px'
		 	# $(child).css 'left', $(child).position().left + i * leftOffset + 'px'
		 	extraHeight = parseInt( $(child).css('height'), 10 ) - (previewHeight - 10)
		 	console.log extraHeight
		 	
		 	
		 	$(child).hover (inEvent) ->
		 		for previous in list[i+1..]
		 			$(previous).css 'top', parseInt( $(previous).css('top'), 10 ) + extraHeight + 'px'
		 	, (outEvent) ->
		 		for previous in list[i+1..]
		 			$(previous).css 'top', parseInt( $(previous).css('top'), 10 ) - extraHeight + 'px'
		 	###
	
	# $('#dotscard').dotdotdot({})
	# $('.card').dotdotdot({})