Nectarine.Views.Contacts ||= {}

class Nectarine.Views.Contacts.ShowView extends Backbone.View
  template: JST["backbone/templates/contacts/show"]

  render: ->
    @$el.html(@template(@model.toJSON() ))
    return this
