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
  didInsertElement: ->
    @set("displayedSubject", @get("selection"))

    @$().on "touchstart mousedown", (e)=>
      @startY = e.pageY
      $(window).on "mousemove", onDrag
      $(window).on "touchstop mouseup", onStop

    onDrag = (e)=>
      d = e.pageY-@startY
      steps = Math.round(d/50)
      @set "displayedSubject", @relativeSubject(steps)

    onStop = =>
      $(window).off "mousemove", onDrag
      $(window).off "touchstop mouseup", onStop

      if @get("selection") != @get("displayedSubject")
        @setSubject @get("displayedSubject")

  filterText: ""
  subjectList: (->
    term = @get("filterText").toLowerCase()
    matches = @get("content").filter (subject)->
      subject.get("title").toLowerCase().indexOf(term)!=-1

    matches.unshift @get("selection")

    matches.slice 0, 20
  ).property("content.@each", "filterText")

  setSubject: (subject)->
    @set("selection", subject)
    @set("displayedSubject", subject)

  # displayedSubject: Ember.Binding.oneWay("selection")

  relativeSubject: (offset)->
    subject = @get("selection")
    content = @get("content")

    index = content.indexOf(subject)+offset
    index = Math.min(content.get("length")-1, index)
    index = Math.max(index, 0)

    content.objectAt(index)

  prevSubject: (->
    @relativeSubject -1
  ).property("content.@each", "selection")

  nextSubject: (->
    @relativeSubject 1
  ).property("content.@each", "selection")
