window.tempScroll = 0
window.onScroll = (e) ->
	
	curScroll = $(document).scrollTop()
	delta = curScroll - window.tempScroll
	window.tempScroll = curScroll	
	
	minHeight = 5
	maxHeight = 800
	
	# top_scale = 1
	# second_scale = 0.2
	# third_scale = 0.05
	
	if !window.stack?
		window.stack = $('.card_stack').first().children()
	
	sum = 0
	_.each window.stack, (child, i, list) ->
		
	
	
	
	
	###
	jchild = $(child)
	jchild.css('top', parseInt(jchild.css('top'), 10) + delta*scale + 'px')

	x = ($(document).scrollTop() - $(child).offset().top) / maxHeight
	
	min = Math.max(minHeight, -700*(x + .2))
	$(child).css('margin-top', Math.min(maxHeight, min) + 'px')
	if not 1 < x < 4

		min = Math.pow(2, 2 * (8 - x)) + minHeight

	console.log Math.max( i * 15 * -1 * $(window).scrollTop(), minHeight) + 'px'
	###
	
	
	
	# top = $(window.stack[window.stack.length - 1])
	# second = $(window.stack[window.stack.length - 2])
	# third = $(window.stack[window.stack.length - 3])
	#
	# for pair in [[top, top_scale], [second, second_scale], [third, third_scale]]
	# 	pair[0].css('top', Math.round(parseInt(pair[0].css('top'), 10) + delta*pair[1]) + 'px')

$(document).scroll( window.onScroll )
	
	
	
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
