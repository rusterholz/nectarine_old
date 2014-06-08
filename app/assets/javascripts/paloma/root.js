var RootController = Paloma.controller('Root');

RootController.prototype.index = function(){
  // $(document).ready() is not necessary here.
  $('#info').append(
    $('<li><p><strong>Paloma:</strong> installed (find this in app/assets/javascripts/paloma/root.js)</p></li>')
  ).append(
    $('<li><p><strong>Underscore:</strong> ' + ( window._ == undefined ? 'missing!' : 'installed') + '</p></li>')
  ).append(
    $('<li><p><strong>Base64:</strong> ' + ( window.Base64 == undefined ? 'missing!' : 'installed') + '</p></li>')
  );
};