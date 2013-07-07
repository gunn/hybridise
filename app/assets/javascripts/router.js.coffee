App.Router.map ->
  @resource "about"
  @resource "subjects", ->
    @resource "subject", path: ":subject_slug"
  @resource "hybrid", path: ":subject1_slug/and/:subject2_slug"#, ->
  #   @resource "suggestion", path: ":id"

App.SubjectsRoute = Ember.Route.extend
  model: ->
    App.Subject.find()

App.SubjectRoute = Ember.Route.extend
  serialize: (model, params)->
    subject_slug: model.get("wiki_slug")

  setupController: (controller, model)->
    controller.set("model", model)
    model.reload() unless model.get("complete")

App.IndexRoute = Ember.Route.extend
  redirect: -> @transitionTo "about"

App.HybridRoute = Ember.Route.extend
  serialize: (model, params)->
    subject1_slug: model.subject1.get("wiki_slug")
    subject2_slug: model.subject2.get("wiki_slug")

  model: (params)->
    subject1: App.Subject.find(params.subject1_slug)
    subject2: App.Subject.find(params.subject2_slug)
