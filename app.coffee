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

get_story_with_image = (story) ->
  for article, index in story
    if article.image?
      if index > 0
        story = [article].concat story[...index].concat story[index..]
      return story
  return story
  
dedupe_story = (story) ->
  titles = {}
  new_story = []
  for article, index in story
    if titles[article.title] != true
      titles[article.title] = true
      new_story.push article
  return new_story
  
dedupe_all_stories = (stories, ordering) ->
  titles = {}
  new_stories = {}
  if !ordering?
    ordering = Object.keys(stories)
  for story in ordering
    for article, index in stories[story]
      if titles[article.title] != true
        titles[article.title] = true
        if !new_stories[story]?
          new_stories[story] = []
        new_stories[story].push article
  return new_stories


app.get '/', (req, res) ->
  # for article in content.articles()
  #   article.pretty_timestamp = moment(article.pubdate).fromNow().toUpperCase()
    
  view = "frontpage"
  if is_mobile(req)
    articles = (article for id, article of content.article_store)
    app.render 'mobile', {'articles': articles}, (err, html) ->
      console.error err if err?
      res.send html
  
  stories = content.get_articles_by_story()
  story_keys = content.rank_stories_by_article_quantity(stories)
  stories = dedupe_all_stories(stories, story_keys)
  
#   yes, repeated - makes sure that we're getting the best of the deduped
  story_keys = content.rank_stories_by_article_quantity(stories)
  
  page_stories = {}
  for key in story_keys[0..11]
    page_stories[key] = get_story_with_image(stories[key])
  # console.log page_stories
  
  
  app.render view, {'stories': page_stories}, (err, html) ->
    console.error err if err?
    res.send html
    
app.get '/shadowbox/:story', (req, res) ->
  console.log 'GET for shadowbox/' + req.params.story
  if is_mobile(req)
    return res.redirect '/'
  
  story_name = req.params.story
  
  stories = content.get_articles_by_story()
  story_keys = content.rank_stories_by_article_quantity(stories)
  stories = dedupe_all_stories(stories, story_keys)
  
  story = get_story_with_image(stories[story_name])
    
  app.render 'shadowbox', {'story': story}, (err, html) ->
    console.error err if err?
    res.send html

    
    

content.start_fetching()

port = process.env.PORT || 1999
app.listen port