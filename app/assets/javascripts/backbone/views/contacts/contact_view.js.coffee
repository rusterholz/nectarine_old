Nectarine.Views.Contacts ||= {}

class Nectarine.Views.Contacts.ContactView extends Backbone.View
  template: JST["backbone/templates/contacts/contact"]

  initialize: (options) ->
    console.log( 'initializing index view, el is:' )
    console.log @$el
    @model = options.model
    # @model.on('change', @render)
    # console.log( 'bound!' )

  events:
    "click .destroy" : "destroy"

  tagName: "tr"

  destroy: () ->
    @model.destroy()
    this.remove()

    return false

  render: ->
    console.log( 'rendering contact!' )
    @$el.html( @template( @model.toJSON() ) )
    return this
