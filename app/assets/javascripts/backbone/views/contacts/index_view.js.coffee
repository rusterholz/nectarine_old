Nectarine.Views.Contacts ||= {}

class Nectarine.Views.Contacts.IndexView extends Backbone.View
  template: JST["backbone/templates/contacts/index"]

  initialize: (options) ->
    console.log( 'initializing index view, el is:' )
    console.log @$el
    @views = []

    _.bindAll( @, 'addAll', 'addOne' )

    @listenTo( @collection, 'reset', @addAll )
    @listenTo( @collection, 'add', @addOne )

  addAll: () =>
    @collection.each(@addOne)

  addOne: (contact) =>
    console.log( 'adding one to view' )
    view = new Nectarine.Views.Contacts.ContactView({ model: contact })
    @$("tbody").append( view.render().el )
    @views.push view

  render: () =>
    console.log( 'rendering index!' )
    @collection.detectDuplicates()
    if @views.length > 0
      _.each( @views, (v) ->
        console.log( 'calling subview render!' )
        v.render()
      )
    else
      @$el.html( @template( @collection ) )
      @addAll()

    return this
