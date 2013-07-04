App.Subject = Em.Model.extend
  title: Em.attr()
  slug: Em.attr()
  wiki_slug: Em.attr()
  text: Em.attr()

App.Subject.primaryKey    = "wiki_slug"
App.Subject.rootKey       = "subject"
App.Subject.collectionKey = "subjects"
App.Subject.url           = "/subjects"
App.Subject.adapter       = Ember.RESTAdapter.create()
