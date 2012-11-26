request = require 'request'
moment = require 'moment'
# $ = require 'jquery'
constants = require '../constants'

NYT_base_url = 'http://api.nytimes.com/svc/'
NYT_section_fragment = 'mostpopular/v2/mostviewed/all-sections/1.json'
NYT_key_fragment = '?api-key=' + constants.nyt_most_popular_key

NYT_url = (offset) ->
	if !offset?
		return NYT_base_url + NYT_section_fragment + NYT_key_fragment
	return NYT_base_url + NYT_section_fragment + NYT_key_fragment + '&offset=' + offset



diffbot_base_url = 'http://www.diffbot.com/api/article'
diffbot_token_fragment = '?token=' + constants.diffbot_token

diffbot_url = (targetURL) ->
	diffbot_base_url + diffbot_token_fragment + '&url=' + targetURL

article_store = {}

fetch = (finished_callback, offset) ->
	console.log 'Fetching NYT at ' + moment().format('dddd, MMMM Do YYYY, h:mm:ss a')
	request NYT_url(offset), (error, response, body) ->
		if !error and response.statusCode == 200
			articles = JSON.parse(body).results
			console.log "Received #{articles.length} results from the NYT."
			for article in articles
				# console.log article.title
				# console.log article.abstract
				# console.log "section: #{article.section}  type: #{article.type}"
				# console.log article.des_facet
				# console.log '\n'
				facets = []
				for facet in article.des_facet
					facets.push facet.replace(/\s+/g, '')
				article.nospace_facets = facets
				if !article_store[article.id]?
					article_store[article.id] = article
					fetch_body article
		# setTimeout( () ->
		# 	get_articles_by_story('ENTREPRENEURSHIP')
		# , 10000)
		if finished_callback?
			finished_callback(article_store)

fetch_many = (finished_callback, count) ->
	queries = Math.ceil(count / 20)
	returned = 0
	increment_returned = ->
		returned++
		if returned == queries
			console.log "Finished fetching NYT."
			if finished_callback?
				return finished_callback(article_store)
			return
	for i in [0...queries]
		fetch(increment_returned, i * 20)
	
fetch_body = (article) ->
	request diffbot_url(article.url), (error, response, body) ->
		if !error and response.statusCode == 200
			text = JSON.parse(body).text
			if text?
				article.text = text.replace("\n", "<br /><br />","g")
			else
				article.text = undefined
			# console.log article_store[article.id]
		else
			console.error """
			\n
			Diffbot error.
			Error: #{error}
			Body: #{body}
			Article:
			"""
			console.error article
			console.error '\n'
			delete article_store[article.id]
			
get_article_by_id = (id) ->
	return article_store[id]
			
get_articles_by_story = (story) ->
	if story?
		story = story.replace(/\s+/g, '')
		stories = {}
		stories[story] = []
		for article_id of article_store
			article = article_store[article_id]
			if article.nospace_facets? and story in article.nospace_facets and article.section != 'Opinion'
				stories[story].push(article)
				# console.log article.title
				# console.log article.abstract
				# console.log "section: #{article.section}  type: #{article.type}"
				# console.log article.des_facet
				# console.log '\n
		return stories
	else
		stories = {}
		for article_id of article_store
			article = article_store[article_id]
			if article.des_facet? and article.section != 'Opinion'
				for facet in article.des_facet
					stories[facet] = [] if !stories[facet]?
					stories[facet].push(article)
		return stories
	
rank_stories_by_article_quantity = (stories) ->
	sorted_keys = Object.keys(stories).sort (one, two) ->
		if stories[one].length > stories[two].length
			return -1
		if stories[two].length > stories[one].length
			return 1
		return 0
	return sorted_keys
	
get_top_stories = ->
	stories = get_articles_by_story()
	story_keys = rank_stories_by_article_quantity(stories)[0..5]

			
start_fetching = ->
	fetch_many(null, 300)
		# console.log "Finished fetching NYT."
		# console.log Object.keys(article_store).length
		# stories = get_articles_by_story()
		# console.log typeof stories
		# console.log Object.keys(stories)
		
		# sorted_keys = Object.keys(stories).sort (one, two) ->
		# 	if stories[one].length > stories[two].length
		# 		return -1
		# 	if stories[two].length > stories[one].length
		# 		return 1
		# 	return 0
		#
		# for key in sorted_keys
		# 	console.log key, stories[key].length
		
	setInterval ->
		fetch_many(null, 500)
	, 60 * (60 * 1000)
	

exports.article_store = article_store
exports.fetch = fetch
exports.get_article_by_id = get_article_by_id
exports.fetch_many = fetch_many
exports.start_fetching = start_fetching
exports.get_articles_by_story = get_articles_by_story
exports.rank_stories_by_article_quantity = rank_stories_by_article_quantity
