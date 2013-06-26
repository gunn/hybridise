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
  heading: (->
    headings = { "about": "About", "subjects": "Subjects" }
    url = @get("target.url")

    headings[url.split("/")[1]]
  ).property("target.url")

App.SubjectsController = Em.ArrayController.extend
  colour: "#666666"
  size: 450
  letterStyle: (->
    "color: #{@colour}; font-size: #{@size}px"
  ).property("colour", "size")

App.SubjectsView = Em.View.extend
  letterStyleBinding: "controller.letterStyle"

App.Subject = Em.Object.extend
  id: null
  letter: (->
    @get "id"
  ).property("id")
