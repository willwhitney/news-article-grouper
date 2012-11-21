window.scrollsum = 0
window.onScroll = (e, d, dx, delta) ->
	if e?
		e.preventDefault()
	window.scrollsum += delta
	window.scrollsum = Math.max(60, window.scrollsum)
	# console.log window.scrollsum
	
	
	if !window.stack?
		window.stack = $('.card_stack').first().children()
	
	minHeight = 20
	maxHeight = 800
	scale = 50
	
	# (30*800 * ( (x/20)^2 + 1) ^ (1/2) - 800*30) / 10 + 30*800 * ( (x/5)^8 + 1) ^ (1/8) - 800*30 + 30
	
	_.each window.stack, (c, i, list) ->
		child = $(c)
		x = scale * window.scrollsum / maxHeight + (i - list.length)
		# x =

		# (30*800 * ( (x/10)^2 + 1) ^ (1/2) - 800*30) / 10 + 30*800 * ( (x/5)^8 + 1) ^ (1/8) - 800*30 + 30
		# term1 = (30*800 * Math.pow( Math.pow(x/20, 2) + 1, 1/2) - 800*30) / 10
		# term2 = 30*800 * Math.pow( Math.pow(x/5, 8) + 1, 1/8) - 800*30 + 30
		
		# 5x + 30*800 * ( (x/10)^8 + 1) ^ (1/8) - 800*30

		# term2 = 150*800 * Math.pow( Math.pow(Math.max(0, x)/3.5, 24) + 1, 1/24) - 800*150
		mult = x/2 + 1
		if x <= -1
			mult = Math.pow(2, x)
		term1 = 5 * mult * i + 30
		
		term2 = 10*800 * Math.pow( Math.pow(Math.max(0, x)/3.5, 24) + 1, 1/24) - 800*10
		
		max = term1 + term2
		
		if i == 1
			console.log x
		
		# height = Math.max(max, minHeight * i)
		height = max
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
