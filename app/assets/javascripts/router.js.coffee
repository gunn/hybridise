App.Router.map ->
  @resource "about"
  @resource "subjects", ->
    @resource "subject", path: ":subject_id"
  @resource "hybrid", path: ":s1_slug/and/:s2_slug", ->
    @resource "suggestion", path: ":id"

App.SubjectsRoute = Ember.Route.extend
  model: ->
    if App.Subject.all().get("length") > 0
      App.Subject.all()
    else
      App.Subject.find()

App.IndexRoute = Ember.Route.extend
  redirect: -> @transitionTo "about"
