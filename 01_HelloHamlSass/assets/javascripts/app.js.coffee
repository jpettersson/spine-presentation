# First, Sprockets would like to know what files we want to include:

# jQuery can play with us.. for now.
//= require 'vendor/jquery-1.8.1.min'

# The HAML js runtime, for errors and such.
//= require 'vendor/haml'

# CommonJs gives us nice module imports.
//= require 'sprockets/commonjs'

# Using the CoffeeScript source of Spine, directly from the symlinked spine submodule.
//= require './vendor/spine/spine'
//= require './vendor/spine/local'

# Require our MVC files
//= require_tree './controllers'
//= require_tree './models'
//= require_tree './templates'

# Importing our Superstars controller with the CommonJS function 'require'.
Superstars = require 'controllers/superstars'

# Creating a minimal root controller to keep a reference to the body tag.
class App extends Spine.Controller

	constructor: ()->
		# it's important to call the super since we are passing in an options
		# object containing the el reference.
		super
		
		# instantiate a Superstars controller
		@superstars = new Superstars

		# append it to @el, which happens to be '<body/>'
		@append @superstars

# Time to start the app, let jQuery kick us off. 
$ ->
	#Instantiate a new Hello controller and pass the body tag as it's element.
	new App
		el: $('body')