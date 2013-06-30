#= require ./patches
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
  init: ->
    App.Subject.find()

  heading: (->
    headings = { "about": "About", "subjects": "Subjects" }
    url = @get("target.url")

    headings[url.split("/")[1]]
  ).property("target.url")

App.SubjectsController = Em.ArrayController.extend
  shownSubjects: (->
    Em.A @get("model").slice(0, 30)
  ).property("model.@each")
