Nectarine.Views.Contacts ||= {}

class Nectarine.Views.Contacts.NewView extends Backbone.View
  template: JST["backbone/templates/contacts/new"]

  events:
    "submit #new-contact": "save"

  constructor: (options) ->
    super(options)
    @model = new @collection.model()

    @model.bind("change:errors", () =>
      this.render()
    )

  save: (e) ->
    e.preventDefault()
    e.stopPropagation()

    @model.unset("errors")

    @collection.create(@model.toJSON(),
      success: (contact) =>
        @model = contact
        window.location.hash = "/#{@model.id}"

      error: (contact, jqXHR) =>
        @model.set({errors: $.parseJSON(jqXHR.responseText)})
    )

  render: ->
    @$el.html(@template(@model.toJSON() ))

    this.$("form").backboneLink(@model)

    return this
