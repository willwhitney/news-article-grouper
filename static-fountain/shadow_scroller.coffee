window.scrollsum = 0
window.onScroll = (e, d, dx, delta) ->
	if e?
		e.preventDefault()
	window.scrollsum += delta
	
	
	if !window.stack?
		window.stack = $('.card_stack').first().children()
	
	minHeight = 20
	maxHeight = 800
	scale = 50
	
	# max(800 * ( x^2 + 1) ^ (1/2) - 800, 50)
	
	_.each window.stack, (c, i, list) ->
		child = $(c)
		x = scale * window.scrollsum / maxHeight + (i - list.length)
		if i == list.length - 1
			console.log x
		max = 800 * Math.pow(( Math.pow(x, 2) + 1), 0.5) - 800
		height = Math.max(max, minHeight)
		child.css('top', Math.round(height) + 'px')
		
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	# top_scale = 50
	# second_scale = 5
	# third_scale = 1
	# top = $(window.stack[window.stack.length - 1])
	# second = $(window.stack[window.stack.length - 2])
	# third = $(window.stack[window.stack.length - 3])
	#
	# for pair in [[top, top_scale], [second, second_scale], [third, third_scale]]
	# 	pair[0].css('top', Math.round(parseInt(pair[0].css('top'), 10) + delta*pair[1]) + 'px')


$(window).mousewheel(window.onScroll)
# $(document).scroll(window.onScroll)
	
	
	
	# _.each stack, (child, i, list) ->
	# 	jchild = $(child)
	# 	jchild.css('top', parseInt(jchild.css('top'), 10) + delta*scale + 'px')
		
		# x = ($(document).scrollTop() - $(child).offset().top) / maxHeight
		#
		# min = Math.max(minHeight, -700*(x + .2))
		# $(child).css('margin-top', Math.min(maxHeight, min) + 'px')
		# if not 1 < x < 4
		
			# min = Math.pow(2, 2 * (8 - x)) + minHeight
		
		# console.log Math.max( i * 15 * -1 * $(window).scrollTop(), minHeight) + 'px'

# window.onscroll = onScroll
