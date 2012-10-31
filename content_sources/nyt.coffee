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

fetch = ->
	console.log 'Fetching NYT at ' + moment().format('dddd, MMMM Do YYYY, h:mm:ss a')
	request NYT_url, (error, response, body) ->
		if !error and response.statusCode == 200
			articles = JSON.parse(body).results
			for article in articles
				article_store[article.id] = article
				fetch_more article
	
fetch_more = (article) ->
	request diffbot_url(article.url), (error, response, body) ->
		if !error and response.statusCode == 200
			article.text = JSON.parse(body).text
			console.log article_store[article.id].text
		else
			console.error """Diffbot error.
			Error: #{error}
			Response: #{response}
			Body: #{body}
			"""

start_fetching = ->
	fetch()
	setInterval ->
		fetch()
	, 5 * (60 * 1000)
	


exports.fetch = fetch
exports.start_fetching = start_fetching