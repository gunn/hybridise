#= require_self
#= require ./patches
#= require_tree ./models
#= require_tree ./controllers
#= require_tree ./views
#= require_tree ./helpers
#= require_tree ./templates
#= require_tree ./routes
#= require ./router

window.App = Ember.Application.create()

App.ApplicationController = Em.Controller.extend
  init: ->
    App.Subject.find()

  heading: (->
    headings = { "about": "About", "subjects": "Subjects" }
    url = @get("target.url")

    headings[url.split("/")[1]]
  ).property("target.url")

App.SubjectsController = Em.ArrayController.extend
  filterTerm: ""
  shownSubjects: (->
    filtered = []
    term = @get("filterTerm").toLowerCase()
    for subject in @get("model").toArray()
      filtered.push(subject) if subject.get("title").toLowerCase().indexOf(term)!=-1
      break if filtered.length >= 35
    filtered
  ).property("model.@each", "filterTerm")

App.HybridController = Em.Controller.extend
  init: ->
    @set "allSubjects", App.Subject.find()

  navigate: (->
    @get("model.subject1").reload()
    @get("model.subject2").reload()

    @transitionToRoute "hybrid"
  ).observes "model.subject1.text", "model.subject2.text"

App.SliderSelectComponent = Ember.Component.extend
  filterText: ""
  subjectList: (->
    term = @get("filterText").toLowerCase()
    matches = @get("content").filter (subject)->
      subject.get("title").toLowerCase().indexOf(term)!=-1

    matches.unshift @get("selection")

    matches.slice 0, 20
  ).property("content.@each", "filterText")

  setSubject: (subject)->
    console.log subject.get("title")
    this.set("selection", subject)

  prevSubject: (->
    subject = @get("selection")
    content = @get("content")

    index = content.indexOf(subject)-1
    index = content.length-1 if index < 0

    content.objectAt(index)
  ).property("content.@each", "selection")

  nextSubject: (->
    subject = @get("selection")
    content = @get("content")

    index = content.indexOf(subject)+1
    index = 0 if index >= content.length

    content.objectAt(index)
  ).property("content.@each", "selection")
