window.onScroll = (e, delta) ->
	# console.log "scrolling!"
	# console.log $(document).scrollTop()
	# console.log e
	e.preventDefault()
	
	minHeight = 5
	maxHeight = 800
	_.each $('.card_stack').first().children(), (child, i, list) ->
		
		
		
		# x = ($(document).scrollTop() - $(child).offset().top) / maxHeight
		#
		# min = Math.max(minHeight, -700*(x + .2))
		# $(child).css('margin-top', Math.min(maxHeight, min) + 'px')
		# if not 1 < x < 4
		
			# min = Math.pow(2, 2 * (8 - x)) + minHeight
		
		# console.log Math.max( i * 15 * -1 * $(window).scrollTop(), minHeight) + 'px'

# window.onscroll = onScroll
$(window).mousewheel(window.onScroll)