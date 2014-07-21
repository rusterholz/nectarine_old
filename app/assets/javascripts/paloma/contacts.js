var ContactsController = Paloma.controller('Contacts');

ContactsController.prototype.index = function(){
  var collection = $.parseJSON( $('#backbone_collection_contacts').val() );
  window.router = new Nectarine.Routers.ContactsRouter( collection );
  console.log( 'Collection has ' + collection.contacts.length + ' items, start: ' + Backbone.history.start() );
};
