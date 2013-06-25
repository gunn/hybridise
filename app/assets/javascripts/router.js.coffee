App.Router.map ->
  @resource "about"
  @resource "subjects", ->
    @resource "subject", path: ":subject_id"
  @resource "hybrid", path: ":s1_slug/and/:s2_slug", ->
    @resource "suggestion", path: ":id"

App.SubjectsRoute = Ember.Route.extend
  model: ->
    for i in [65..90]
      App.Subject.create
        id: String.fromCharCode(i)

App.SubjectRoute = Ember.Route.extend
  model: (params)->
    App.Subject.create
      id: params.subject_id

App.IndexRoute = Ember.Route.extend
  redirect: -> @transitionTo "about"
