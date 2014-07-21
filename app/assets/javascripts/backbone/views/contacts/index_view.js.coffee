Nectarine.Views.Contacts ||= {}

class Nectarine.Views.Contacts.IndexView extends Backbone.View
  template: JST["backbone/templates/contacts/index"]

  initialize: (options) ->
    console.log( 'initializing index view' )
    @views = []
    @collection.bind('reset', @addAll)

  addAll: () =>
    @collection.each(@addOne)

  addOne: (contact) =>
    view = new Nectarine.Views.Contacts.ContactView({ model: contact })
    @$("tbody").append( view.render().el )
    @views.push view

  render: =>
    console.log( 'rendering index!' )
    if @views.length > 0
      _.each( @views, (v) ->
        console.log( 'calling subview render!' )
        v.render()
      )
    else
      @$el.html( @template( contacts: @collection.toJSON() ) )
      @addAll()

    return this
