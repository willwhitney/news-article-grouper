articleHoverIn = (e) ->
	for card in $(this).siblings() when $(card).index() > $(this).index()
		$(card).addClass('transparent')
		
articleHoverOut = (e) ->
	for card in $(this).siblings() when $(card).index() > $(this).index()
		$(card).removeClass('transparent')

		
$ ->
	$('.card').hover(articleHoverIn, articleHoverOut)