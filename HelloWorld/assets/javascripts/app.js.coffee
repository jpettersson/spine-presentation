//= require 'vendor/jquery-1.8.1.min'
//= require 'vendor/haml'

//= require 'sprockets/commonjs'

//= require './lib/spine/src/spine'

//= require_tree './controllers'
//= require_tree './models'
//= require_tree './templates'

Hello = require 'controllers/hello'

$ ->
	new Hello
		el: $('body')