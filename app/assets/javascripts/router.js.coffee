App.Router.map ->
  @resource "about"
  @resource "subjects", ->
    @resource "subject", path: ":subject_slug"
  @resource "hybrid", path: ":slug1/and/:slug2"#, ->
  #   @resource "suggestion", path: ":id"

App.SubjectsRoute = Ember.Route.extend
  model: ->
    App.Subject.find()

App.SubjectRoute = Ember.Route.extend
  serialize: (model, params)->
    subject_slug: model.get("wiki_slug")

  setupController: (controller, model)->
    controller.set("model", model)
    model.reload() if Em.isEmpty(model.get("text"))

App.IndexRoute = Ember.Route.extend
  redirect: -> @transitionTo "about"

App.HybridRoute = Ember.Route.extend
  model: (params)->
    subject1: App.Subject.findById(params.slug1)
    subject2: App.Subject.findById(params.slug2)
