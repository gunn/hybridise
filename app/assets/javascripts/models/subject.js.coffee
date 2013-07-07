App.Subject = Em.Model.extend
  title: Em.attr()
  slug: Em.attr()
  wiki_slug: Em.attr()
  complete: Em.attr()
  text: Em.attr()

  reload: ->
    unless @get("isLoading") || @get("complete")
      @set "isLoaded", false
      @_super()

  load: (id, hash)->
    if !@get("complete") || hash.complete
      @_super(id, hash)

App.Subject.primaryKey    = "wiki_slug"
App.Subject.rootKey       = "subject"
App.Subject.collectionKey = "subjects"
App.Subject.url           = "/subjects"
App.Subject.adapter       = Ember.RESTAdapter.create
  # hack for ember-model bug
  findMany: null
