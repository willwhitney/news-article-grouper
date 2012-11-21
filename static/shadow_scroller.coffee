window.scrollsum = 0
window.onScroll = (e, d, dx, delta) ->
	if e?
		e.preventDefault()

	window.scrollsum += delta
	window.scrollsum = Math.max(60, window.scrollsum)

	# cache this lookup
	if !window.stack?
		window.stack = $('.card_stack').first().children()
	
	minHeight = 20
	maxHeight = 800
	scale = 50
		
	_.each window.stack, (c, i, list) ->
		child = $(c)
		
		# scale the scroll speed
		x = scale * window.scrollsum / maxHeight + (i - list.length)

		# mix of early exponential behavior (for asymptote) and linear
		mult = x/2 + 1
		if x <= -1
			mult = Math.pow(2, x)
		term1 = 5 * mult * i + 30
		#       ^               ^
		#       |               |
		# speed of linearity  top offset
		
		
		# hyperbola, for proper end behavior
		term2 = 10*800 * Math.pow( Math.pow(Math.max(0, x)/3.5, 24) + 1, 1/24) - 800*10
		#         ^                                         ^    ^         ^         ^
		#         |                                         |    |         |         |
		#     final slope                         width of flat  sharpness of bend   pull down to 0
		
		max = term1 + term2
				
		height = max
		child.css('top', Math.round(height) + 'px')
	
$(window).mousewheel(window.onScroll)
