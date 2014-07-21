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
    ".*"        : "index"

  newContact: ->
    @view = new Nectarine.Views.Contacts.NewView(collection: @contacts)
    $("#contacts").html(@view.render().el)

  index: ->
    @view = new Nectarine.Views.Contacts.IndexView(collection: @contacts)
    console.log( 'executing index route, view.render.el gives:' )
    console.log( vre = @view.render().el )
    $("#contacts").html( vre )

  show: (id) ->
    contact = @contacts.get(id)

    @view = new Nectarine.Views.Contacts.ShowView(model: contact)
    $("#contacts").html(@view.render().el)

  edit: (id) ->
    contact = @contacts.get(id)

    @view = new Nectarine.Views.Contacts.EditView(model: contact)
    $("#contacts").html(@view.render().el)
