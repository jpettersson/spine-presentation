Star = require 'models/star'

class Superstars extends Exo.Controller

	# This class will create it's own div upon instantiation, 
	# this will be it's CSS class. 
	className: 'superstars'

	# Use jQuery to select a few elements and store them as 
	# @instance variables.
	elements: 
		'.items': 'itemsEl'
		'.input input': 'inputEl'

	# Similarly, we have this jQuery shortcut to bind to some 
	# interesting DOM events.
	events:
		'keyup .input input': 'createStar'
		'click button': 'deleteStar'

	prepare: ->
		# first, draw the DOM objects we need.
		@render()
		
		# The Exo.List will render our collection of Star objects and 
		# instantiate/destroy appropriate controllers.
		# Note how Exo.List is inheriting from Spine.Controller and can be 
		# assigned an element by passing in the 'el' parameter.
		# We are also specifying a controller class to handle each item in 
		# the collection.
		@list = new Exo.List
			el: @itemsEl
			controller: require 'controllers/star'

		# Initialize the local storage for our model. In an AJAX situation we would run this 
		# when we want new data from the server.
		Star.fetch()

		# No data is no fun, let's create some default Stars.
		Star.createDefaults()

	render: =>
		@html JST['templates/superstars']()

	renderList: =>
		@list.render Star.all()

	doActivate: ->
		TweenLite.from(@el, 3, {
			css: {
				left: -500
				rotation: 90
				alpha: 0
			},
			ease: Elastic.easeOut,
			onComplete: @onActivated
		})

	onActivated: =>
		Star.bind 'refresh change', @renderList
		@renderList()

		# making the .input visible before the animation
		$('.input').show()
		TweenLite.from($('.input'), 5, {
			css: {
				alpha: 0
			},
		})

		super

	createStar: (e) ->
		# enter was pressed? we have some content?
		if e.keyCode == 13 & @inputEl.val().length > 0
			
			# create a new Star record 
			star = new Star
				name: @inputEl.val()
				optional: true
			
			# save record to local storage
			star.save()

			# clear the input field
			@inputEl.val('')

	deleteStar: (e) ->
		id = $(e.target).attr('data-id')
		star = Star.find(id)
		star.destroy() if star

module.exports = Superstars