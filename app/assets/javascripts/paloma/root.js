var RootController = Paloma.controller('Root');

RootController.prototype.index = function(){
  // $(document).ready() is not necessary here.
  var info = $('#info').append(
    $('<dt>Paloma:</dt><dd>installed (find this in app/assets/javascripts/paloma/root.js)</dd>')
  ).append(
    $('<dt>Underscore:</dt><dd>' + ( window._ == undefined ? 'missing' : 'installed') + '</dd>')
  ).append(
    $('<dt>Base64:</dt><dd>' + ( window.Base64 == undefined ? 'missing' : 'installed') + '</dd>')
  ).append(
    $('<dt>Websockets:</dt><dd id=\'websocket-info\'>' + ( window.WebSocketRails == undefined ? 'missing' : 'installed' ) + '</dd>')
  );

  if( window.WebSocketRails != undefined ){
    var ws_tick_ms = 750;
    var ws_port = 3001;
    var ws_uri = window.location.hostname + ':' + ws_port + '/websocket';
    var ws_check = function(){
      switch( window.dispatcher.state ){
        case 'connected':
          $('#websocket-info').text( 'installed -- connected to server at ' + ws_uri );
          break;
        case 'connecting':
          $('#websocket-info').text( $('#websocket-info').text() + '.' );
          setTimeout( ws_check, ws_tick_ms );
          break;
        case 'disconnected':
          $('#websocket-info').text( 'installed -- no server appears to be running at ' + ws_uri );
          break;
        default:
          console.log( window.dispatcher.state );
          break;
      }
    };
    $('#websocket-info').text( 'installed -- trying to connect..' );
    window.dispatcher = new WebSocketRails( ws_uri );
    setTimeout( ws_check, ws_tick_ms );
  }
};
