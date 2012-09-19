# First, Sprockets would like to know what files we want to include:

# jQuery can play with us.. for now.
//= require 'vendor/jquery-1.8.1.min'

# The HAML js runtime, for errors and such.
//= require 'vendor/haml'

# CommonJs gives us nice module imports.
//= require 'sprockets/commonjs'

# Using the CoffeeScript source of Spine, directly from the symlinked spine submodule.
//= require './vendor/spine/spine'

# Require our MVC(T) files
//= require_tree './controllers'
//= require_tree './models'
//= require_tree './templates'

# Importing our Hello controller with the CommonJS function 'require'.
Hello = require 'controllers/hello'

# Time to start the app, let jQuery kick us off. 
$ ->

	#Instantiate a new Hello controller and pass the body tag as it's element.
	new Hello
		el: $('body')