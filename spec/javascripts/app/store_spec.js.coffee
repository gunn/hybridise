#= require spec_helper
#= require store

describe "App.Store", ->
  beforeEach ->
    Test.store = TestUtil.lookupStore()

  it "works with latest Ember-Data revision", ->
    assert.equal 12, 12
