Star = require 'models/star'

class Superstars extends Spine.Controller

	className: 'superstars'

	elements: 
		'.items': 'itemsEl'

	constructor: (opts={})->
		super opts

		Star.bind 'refresh change', @render
		Star.fetch()
		Star.createDefaults()

		@render()
		
	render: =>
		console.log 'Render'
		stars = Star.all().map((star) -> JST['templates/star'](name: star.name)).join('')
		@html JST['templates/superstars']({stars: stars})

module.exports = Superstars