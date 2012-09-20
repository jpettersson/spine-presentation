class Star extends Spine.Model
	@configure "Star", "name", "optional"
	@extend Spine.Model.Local

	@DEFAULTS: ['CoffeeScript', 'Spine', 'HAML', "SASS"]

	@createDefaults: ->
		for name in @DEFAULTS
			if Star.select((star) -> star.name == name).length == 0
				star = new Star
					name: name
					optional: false
					
				star.save()

module.exports = Star