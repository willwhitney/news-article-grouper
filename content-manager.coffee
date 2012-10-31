guardian = require './content_sources/guardian'
nyt = require './content_sources/nyt'

exports.start_fetching = ->
	nyt.fetch()