guardian = require './content_sources/guardian'
nyt = require './content_sources/nyt'

exports.start_fetching = ->
	nyt.start_fetching()
	
exports.get_articles_by_story = nyt.get_articles_by_story
exports.rank_stories_by_article_quantity = nyt.rank_stories_by_article_quantity
exports.get_article_by_id = nyt.get_article_by_id
