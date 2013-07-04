App.Router.map ->
  @resource "about"
  @resource "subjects", ->
    @resource "subject", path: ":subject_id"
  # @resource "hybrid", path: ":s1_slug/and/:s2_slug", ->
  #   @resource "suggestion", path: ":id"

App.SubjectsRoute = Ember.Route.extend
  model: ->
    App.Subject.find()

App.SubjectRoute = Ember.Route.extend
  serialize: (model, params)->
    subject_id: model.get("wiki_slug")

  setupController: (controller, model)->
    controller.set("model", model)
    model.reload() if Em.isEmpty(model.get("text"))

App.IndexRoute = Ember.Route.extend
  redirect: -> @transitionTo "about"
