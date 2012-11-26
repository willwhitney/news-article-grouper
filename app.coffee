express = require 'express'
lessMiddleware = require 'less-middleware'
moment = require 'moment'
content = require './content-manager'

app = express()
app.configure ->
  app.set 'views', __dirname + '/views'
  app.set 'view engine', 'jade'
  app.use("/styles", lessMiddleware({ src: __dirname + '/styles'}))
  app.use("/styles", express.static(__dirname + '/styles'))
  app.use("/sources", express.static(__dirname + '/sources'))

is_mobile = (req) ->
  ua = req.header('user-agent')
  if (/mobile/i.test(ua))
    return true
  else return false

app.get '/', (req, res) ->
  # for article in content.articles()
  #   article.pretty_timestamp = moment(article.pubdate).fromNow().toUpperCase()
    
  view = "frontpage"
  if is_mobile(req)
    view = "mobile"
  
  stories = content.get_articles_by_story()
  story_keys = content.rank_stories_by_article_quantity(stories)[0..5]
  
  page_stories = {}
  for key in story_keys
    page_stories[key] = stories[key]
  # console.log page_stories
  
  
  app.render view, {'stories': page_stories}, (err, html) ->
    console.error err if err?
    res.send html
    
app.get '/shadowbox/:story', (req, res) ->
  console.log 'GET for shadowbox/' + req.params.story
  if is_mobile(req)
    return res.redirect '/'
  
  story_name = req.params.story
  story = content.get_articles_by_story(story_name)[story_name]
    
  app.render 'shadowbox', {'story': story}, (err, html) ->
    console.error err if err?
    res.send html

    
    

content.start_fetching()

port = process.env.PORT || 1999
app.listen port