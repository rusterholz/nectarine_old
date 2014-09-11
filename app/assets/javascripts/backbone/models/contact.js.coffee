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

  columns:
    id: 'ID'
    first_name: 'First Name'
    last_name: 'Last Name'
    birthdate: 'DOB'
    age: 'Age'
    gender: 'Gender'
    ethnicity: 'Ethnicity'
    description: 'Description'

  fields:
    first_name: 'text'
    last_name: 'text'
    birthdate: 'date'
    age: 'number'
    gender: 'text'
    ethnicity: 'text'
    description: 'text'

  initialize: () ->
    console.log( 'initializing contact' )
    @on( 'change:last_name', (model) ->
      console.log( 'contact changed last name' )
    )
    @on( 'change', (model) ->
      console.log( 'contact changed' )
    )

  tagFresh: () ->
    @fresh = moment()



class Nectarine.Collections.ContactsCollection extends Backbone.Collection
  model: Nectarine.Models.Contact

  url: '/contacts'

  channel_name: 'contacts'

  initialize: () ->
    console.log( 'initializing contact collection' )
    @columns = @model.prototype.columns
    @fields = @model.prototype.fields

    _.bindAll( @, 'onCreate', 'onUpdate', 'onDelete', 'onAdd', 'detectDuplicates' )
    @innervate()

  innervate: () ->
    @channel = window.medulla.channel( @channel_name )
    @channel.bind( 'create', @onCreate )
    @channel.bind( 'update', @onUpdate )
    @channel.bind( 'delete', @onDelete )
    @listenTo( @, 'add', @onAdd )
    console.log( "bound to channel #{@channel_name}" )

  onCreate: ( data ) ->
    console.log( "received created contact #{data.id}" )
    medulla.refresh()
    @add( data )

  onUpdate: ( data ) ->
    console.log( "received updated contact #{data.id}" )
    medulla.refresh()
    m = @get( data.id )
    if m?
      delete data.id
      m.set( data )
    else
      console.log( "... but could not find it in the collection!" )

  onDelete: ( data ) ->
    console.log( "received deleted contact #{data.id}" )
    medulla.refresh()
    m = @get( data.id )
    if m?
      @remove( m )
    else
      console.log( "... but could not find it in the collection!" )

  onAdd: ( object ) ->
    object.tagFresh() if object.attributes.id == null
    @detectDuplicates()

  detectDuplicates: () ->
    rem = _.bind( @remove, @ )
    byID = {}
    _.each @models, (m) ->
      key = String(m.attributes.id)
      byID[ key ] ||= []
      byID[ key ].push(m)
    _.each byID, (set,id) ->
      if set.length > 1
        itinerant = []
        canon = []
        _.each set, (m) ->
          if m.fresh?
            itinerant.push m
          else
            canon.push m
        console.log( "#{itinerant.length} itinerant and #{canon.length} canon models found with id #{id}" )
        if canon.length > 0 && itinerant.length > 0
          _.each itinerant, rem
        if canon.length > 1
          canon.shift()
          _.each canon, rem




