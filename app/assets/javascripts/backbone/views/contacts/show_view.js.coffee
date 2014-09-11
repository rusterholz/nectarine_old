Nectarine.Views.Contacts ||= {}

class Nectarine.Views.Contacts.ShowView extends Backbone.View
  template: JST["backbone/templates/contacts/show"]

  initialize: (options) ->
    console.log( 'initializing show view, el is:' )
    console.log @$el

    _.bindAll( @, 'onChange' )
    @listenTo( @model, 'change', @onChange )

  render: ->
    router.contacts.detectDuplicates()
    console.log( 'rendering show!' )
    @$el.html( @template( @model ) )
    return this

  onChange: ->
    @render()
