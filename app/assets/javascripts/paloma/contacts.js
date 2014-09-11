var ContactsController = Paloma.controller('Contacts');

ContactsController.prototype.index = function(){
  if( Nectarine.Routers.ContactsRouter != undefined ){

    var collection = $.parseJSON( $('#medulla_collection_contacts').val() );
    window.router = new Nectarine.Routers.ContactsRouter( collection );
    if( Backbone.history.start() ){
      $('#contacts-classic').css({ display: 'none' });
      console.log( 'Backbone started with collection of length ' + collection.contacts.length );
    }

  }
};
