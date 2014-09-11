class Nectarine.Routers.ContactsRouter extends Backbone.Router
  initialize: (options) ->
    console.log( 'initializing contacts router' )
    @contacts = new Nectarine.Collections.ContactsCollection()
    @contacts.reset options.contacts

  routes:
    "new"      : "newContact"
    "index"    : "index"
    ":id/edit" : "edit"
    ":id"      : "show"
    ".*"       : "index"

  newContact: ->
    console.log( 'routed to newContact' )
    @view = new Nectarine.Views.Contacts.NewView( collection: @contacts )
    $("#contacts").html( @view.render().el )
    window.attachPickers()

  index: ->
    console.log( 'routed to index' )
    @view = new Nectarine.Views.Contacts.IndexView( collection: @contacts )
    $("#contacts").html( @view.render().el )

  show: (id) ->
    console.log( 'routed to show' )
    @view = new Nectarine.Views.Contacts.ShowView( model: @contacts.get( id ) )
    $("#contacts").html( @view.render().el )

  edit: (id) ->
    console.log( 'routed to edit' )
    @view = new Nectarine.Views.Contacts.EditView( model: @contacts.get( id ) )
    $("#contacts").html( @view.render().el )
    window.attachPickers()
