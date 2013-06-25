App.Router.map ->
  @resource "about"
  @resource "subjects", ->
    @resource "subject", path: ":subject_slug"
  @resource "hybrid", path: ":s1_slug/and/:s2_slug", ->
    @resource "suggestion", path: ":id"

App.IndexRoute = Ember.Route.extend
  redirect: -> @transitionTo "about"
