Nectarine.Views.Contacts ||= {}

class Nectarine.Views.Contacts.EditView extends Backbone.View
  template: JST["backbone/templates/contacts/edit"]

  events:
    "submit #edit-contact": "update"

  update: (e) ->
    e.preventDefault()
    e.stopPropagation()

    @model.save(null,
      success: (contact) =>
        @model = contact
        window.location.hash = "/#{@model.id}"
    )

  render: ->
    @$el.html(@template(@model.toJSON() ))

    this.$("form").backboneLink(@model)

    return this
