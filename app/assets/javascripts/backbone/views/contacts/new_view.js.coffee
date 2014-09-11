Nectarine.Views.Contacts ||= {}

class Nectarine.Views.Contacts.NewView extends Backbone.View
  template: JST["backbone/templates/contacts/new"]

  initialize: (options) ->
    console.log( 'initializing new view, el is:' )
    console.log @$el

  events:
    "click #submit-form": "save"

  constructor: (options) ->
    super(options)
    @model = new @collection.model()

    _.bindAll( @, 'onChange' )
    @listenTo( @model, 'change', @onChange )

  save: (e) ->
    e.preventDefault()
    e.stopPropagation()

    @model.unset('errors')

    @collection.create(@model.toJSON(),
      success: (contact) =>
        @model = contact
        window.location.hash = "/#{@model.id}"

      error: (contact, jqXHR) =>
        @model.set({errors: $.parseJSON(jqXHR.responseText)})
    )

  render: () ->
    @$el.html( @template( @model ) )
    @.$('form').backboneLink( @model )
    @

  onChange: () ->
    @render()


