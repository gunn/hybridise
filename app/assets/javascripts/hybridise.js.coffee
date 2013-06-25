#= require ./store
#= require_tree ./models
#= require_tree ./controllers
#= require_tree ./views
#= require_tree ./helpers
#= require_tree ./templates
#= require_tree ./routes
#= require ./router
#= require_self

App.ApplicationController = Em.Controller.extend
  heading: (->
    headings = { "/about": "About", "/subjects": "Subjects" }
    url = @get("target.url")

    headings[url]
  ).property("target.url")
