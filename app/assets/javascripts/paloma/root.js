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

};
