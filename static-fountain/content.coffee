$ ->
	ArticleView = Backbone.View.extend {
		el: $('#content')
		
		initialize: ->
			_.bindAll(this, 'render')
			this.render()
		
		render: ->
			$(this.el).append "<h1>hi</h1>"
	}
	
	articleView = new ArticleView()
