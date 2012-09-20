class Star extends Exo.Model
	@configure "Star", "name", "optional"
	@extend Spine.Model.Local

	@DEFAULTS: [
		'Transition State Machines',
		'Enhanced Models',
		'???'
	]

	@createDefaults: ->
		for name in @DEFAULTS
			if Star.select((star) -> star.name == name).length == 0
				star = new Star
					name: name
					optional: false

				star.save()

module.exports = Star