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
		@render()
		console.log @itemsEl
		@list = new Exo.List
			el: @itemsEl
			controller: require 'controllers/star'

		# Initialize the local storage for our model. In an AJAX situation we would run this 
		# when we want new data from the server.
		Star.fetch()

		# No data is no fun, let's create some default Stars.
		Star.createDefaults()


	render: =>
		#		stars = Star.all().map((star) -> element = JST['templates/star'](star)).join('')		
		@html JST['templates/superstars']()

	renderList: =>
		console.log 'Render list'
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