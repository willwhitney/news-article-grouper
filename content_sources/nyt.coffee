request = require 'request'
moment = require 'moment'
constants = require '../constants'

NYT_base_url = 'http://api.nytimes.com/svc/'
NYT_section_fragment = 'mostpopular/v2/mostviewed/all-sections/1.json'
NYT_key_fragment = '?api-key=' + constants.nyt_most_popular_key
NYT_url = NYT_base_url + NYT_section_fragment + NYT_key_fragment

diffbot_base_url = 'http://www.diffbot.com/api/article'
diffbot_token_fragment = '?token=' + constants.diffbot_token

diffbot_url = (targetURL) ->
	diffbot_base_url + diffbot_token_fragment + '&url=' + targetURL

article_store = {}

fetch = (finished_callback) ->
	console.log 'Fetching NYT at ' + moment().format('dddd, MMMM Do YYYY, h:mm:ss a')
	request NYT_url, (error, response, body) ->
		if !error and response.statusCode == 200
			articles = JSON.parse(body).results
			for article in articles
				# console.log article.title
				# console.log article.abstract
				# console.log "section: #{article.section}  type: #{article.type}"
				# console.log article.des_facet
				# console.log '\n'
				article_store[article.id] = article
				fetch_more article
		setTimeout( () ->
			console.log(JSON.stringify(article_store))
		, 10000)
			# get_articles_by_story('PRESIDENTIAL ELECTION OF 2012')
	
fetch_more = (article) ->
	request diffbot_url(article.url), (error, response, body) ->
		if !error and response.statusCode == 200
			article.text = JSON.parse(body).text
			# console.log article_store[article.id]
		else
			console.error """Diffbot error.
			Error: #{error}
			Response: #{response}
			Body: #{body}
			"""
			
# fetch_more_multiple = (articles)

get_articles_by_story = (story) ->
	for article_id of article_store
		article = article_store[article_id]
		if article.des_facet? and story in article.des_facet and article.section != 'Opinion'
			console.log article.title
			console.log article.abstract
			console.log "section: #{article.section}  type: #{article.type}"
			console.log article.des_facet
			console.log '\n'
	process.exit(0)
			
start_fetching = ->
	fetch()
	setInterval ->
		fetch()
	, 5 * (60 * 1000)
	


exports.fetch = fetch
exports.start_fetching = start_fetching
exports.get_articles_by_story = get_articles_by_story