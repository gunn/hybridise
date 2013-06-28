App.Router.map ->
  @resource "about"
  @resource "subjects", ->
    @resource "subject", path: ":subject_id"
  # @resource "hybrid", path: ":s1_slug/and/:s2_slug", ->
  #   @resource "suggestion", path: ":id"

App.SubjectsRoute = Ember.Route.extend
  model: ->
    App.Subject.all()

App.SubjectRoute = Ember.Route.extend
  serialize: (model, params)->
    subject_id: model.get("wikiSlug")

  model: (params)->
    App.Subject.find(params.subject_id)

App.IndexRoute = Ember.Route.extend
  redirect: -> @transitionTo "about"
