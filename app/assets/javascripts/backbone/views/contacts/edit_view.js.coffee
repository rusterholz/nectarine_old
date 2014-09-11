Nectarine.Views.Contacts ||= {}

class Nectarine.Views.Contacts.EditView extends Backbone.View
  template: JST["backbone/templates/contacts/edit"]

  initialize: (options) ->
    console.log( 'initializing edit view, el is:' )
    console.log @$el

  events:
    "click #submit-form": "update"

  update: (e) ->
    console.log( 'triggering update')
    e.preventDefault()
    e.stopPropagation()
    console.log( @model.changed )
    @model.save( {},
      success: (contact) =>
        console.log( 'successfully updated model for edit view' )
        @model = contact
        window.location.hash = "/#{@model.id}"
    )

  render: ->
    console.log( 'rendering edit!' )
    @$el.html( @template( @model ) )
    this.$("form").backboneLink( @model )
    return this
