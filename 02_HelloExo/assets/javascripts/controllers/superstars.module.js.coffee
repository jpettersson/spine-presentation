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

	constructor: ->
		super

		# Run our render method everytime there's an update to the Star model.
		# Fires on every CRUD method, etc.
		Star.bind 'refresh change', @render
		
		# Initialize the local storage for our model. In an AJAX situation we would run this 
		# when we want new data from the server.
		Star.fetch()

		# No data is no fun, let's create some default Stars.
		Star.createDefaults()

		# Let's render once to get our header and other elements on screen while we 
		# await the Stars (in an AJAX situation this could actually take some time).
		@render()
	
	# Every controller should have a render method. It's responsible for creating all DOM objects.
	# It's also important that it can run whenever it needs to so it should not depend on any state. 
	# 'What render wants render gets'			
	render: =>

		# 1. Fetch zero or more Star records.
		# 2. Using map, turn the collection of Star objects into HTML.
		# 3. This is done by executing the precompiled JS function that corresponds to the 
		# 'templates/star' HAML file. Just as in Rails, we pass in the record object as an argument.
		# 4. The join turns our mapped collection of strings into one string.
		stars = Star.all().map((star) -> element = JST['templates/star'](star)).join('')

		# Now it's time to render the template corresponding to _this_ controller. This time 
		# we pass in our already prepared string of stars.
		@html JST['templates/superstars']({stars: stars})

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