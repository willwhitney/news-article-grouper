cardClick = (e) ->
	story = $(this).parent('.card_stack').attr('id')
	document.location.href = "/shadowbox/#{story}"
		
$ ->
	$('.card').click(cardClick)