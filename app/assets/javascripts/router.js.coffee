App.Router.map ->
  @resource "about"
  @resource "subjects", ->
    @resource "subject", path: ":subject_slug"
  @resource "hybrid", path: ":s1_slug/and/:s2_slug", ->
    @resource "suggestion", path: ":id"

App.SubjectsRoute = Ember.Route.extend
  model: ->
    for i in [65..90]
      String.fromCharCode(i)

App.IndexRoute = Ember.Route.extend
  redirect: -> @transitionTo "about"
