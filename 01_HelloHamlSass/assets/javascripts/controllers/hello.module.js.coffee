class Main extends Spine.Controller

	constructor: (opts={})->
		super opts
		@render()

	render: ->
		console.log JST
		@html JST['templates/hello']({superstar: 'HAML!'}) #({hello: 'hi'})

module.exports = Main