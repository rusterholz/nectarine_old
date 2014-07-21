class Nectarine.Models.Contact extends Backbone.Model
  paramRoot: 'contact'

  defaults:
    first_name: null
    last_name: null
    birthdate: null
    age: null
    gender: null
    ethnicity: null
    description: null
    id: null

  initialize: () ->
    console.log( 'initializing contact' )
    @on( 'change:last_name', (model) ->
      console.log( 'contact changed last name' )
    )
    @on( 'change', (model) ->
      console.log( 'contact changed' )
    )

class Nectarine.Collections.ContactsCollection extends Backbone.Collection
  model: Nectarine.Models.Contact
  url: '/contacts'
  initialize: () ->
    console.log( 'initializing contact collection' )
