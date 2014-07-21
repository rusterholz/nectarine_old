class Pulse
  constructor: (options) ->
    console.log( 'initializing pulse' )
    @el = options.el
    @port = options.port
    @uri = window.location.hostname + ':' + @port
    @el.tooltip( @tt_options() )
    @dispatcher().on_open = _.bind( @onConnect, @ )
    @dispatcher().bind('pulse_event', _.bind( @onPulse, @ ) )

  dispatcher: () ->
    window.dispatcher ||= new WebSocketRails( @uri )

  tooltip: () ->
    switch @dispatcher().state
      when 'connected' then return 'Connected'
      when 'connecting' then return 'Connecting to port ' + @port + ' ...'
      when 'disconnected' then return 'Not Connected'

  onConnect: () ->
    console.log( 'pulse connected' )

  onPulse: () ->
    @last_pulse = +new Date

  tt_options: () ->
    (
      html: true
      placement: 'right'
      trigger: 'hover focus'
      title: _.bind( @tooltip, @ )
    )

