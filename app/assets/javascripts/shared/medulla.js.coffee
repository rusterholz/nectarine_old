window.Medulla = (options) ->
  console.log( 'initializing medulla' )
  @port = parseInt(options.port) || Medulla.default_port
  @uri = "#{window.location.hostname}:#{@port}/websocket"
  @channels = {}
  _.bindAll( @, 'onConnect', 'onPulse', 'status', 'refresh', 'heartbeat' )
  @el = $(options.el)
  @el.tooltip( @tooltip_options() )
  @

Medulla.default_port = 3001
Medulla.heartbeat_pulse_time_ms = ( 8 * 1000 )
Medulla.heartbeat_timeout_ms = ( 5 * 60 * 1000 )

Medulla.prototype.channel = (name) ->
  @channels[name] ||= @connection().subscribe(name)

Medulla.prototype.connection = () ->
  unless @socket?
    @socket = new WebSocketRails( @uri )
    @socket.on_open = @onConnect
    @startHeartbeat()
  @socket

Medulla.prototype.status = () ->
  return 'Not Connected' unless @socket?
  switch @connection.state
    when 'connected' then return "Connected (#{@stale_time( true )} since last contact)"
    when 'connecting' then return "Connecting to port #{@port}..."
    when 'disconnected' then return 'Not Connected'

Medulla.prototype.onConnect = () ->
  console.log( 'medulla connected' )
  @refresh()

Medulla.prototype.onPulse = ( data = {} ) ->
  console.log( 'pulse!' )
  @refresh()

Medulla.prototype.refresh = () ->
  @last_contact = moment()

Medulla.prototype.stale_time = ( formatted = false ) ->
  duration = moment() - @last_contact
  if( !formatted )
    duration
  else if( duration < 30000 )
    "#{moment.utc(duration).format('s.SSS')} sec"
  else if( duration < 60000 )
    moment.utc(duration).format('m:ss.SS')
  else if( duration < 300000 )
    moment.utc(duration).format('m:ss.S')
  else if( duration < 1800000 )
    moment.utc(duration).format('m:ss')
  else
    'over 30 minutes'

Medulla.prototype.startHeartbeat = () ->
  @heartbeat() unless @pulse

Medulla.prototype.heartbeat = () ->
  if @stale_time( false ) > Medulla.heartbeat_timeout_ms
    alert( "No contact from server in #{@stale_time(true)}, you may want to refresh..." )
  else
    @pulse = setTimeout( @heartbeat, Medulla.heartbeat_pulse_time_ms )
    @flare( @el )

Medulla.prototype.flare = (el) ->
  el.animate( {color: 'white'}, 300, 'swing', () ->
    el.animate( {color: '#999'}, 300 )
  )

Medulla.prototype.tooltip_options = () ->
  (
    html:      true
    placement: 'bottom'
    trigger:   'hover focus'
    title:     @status
  )

$(document).ready( () ->
  window.medulla ||= new Medulla(
    port: 3001
    el: $('#root-link')
  )
)
