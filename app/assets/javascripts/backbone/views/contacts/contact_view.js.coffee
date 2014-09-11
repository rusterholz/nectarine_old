Nectarine.Views.Contacts ||= {}

class Nectarine.Views.Contacts.ContactView extends Backbone.View
  template: JST["backbone/templates/contacts/contact"]

  initialize: (options) ->
    console.log( 'initializing contact view, el is:' )
    console.log @$el
    @model = options.model

    rdr = _.bind( @render, @ )
    @listenTo( @model, 'change', rdr )
    rem = _.bind( @remove, @ )
    @listenTo( @model, 'remove', rem )

  events:
    "click .destroy" : "destroy"

  tagName: "tr"

  destroy: () ->
    @model.destroy()
    @remove()
    false

  render: ->
    console.log( 'rendering contact!' )
    @$el.html( @template( @model ) )
    @
