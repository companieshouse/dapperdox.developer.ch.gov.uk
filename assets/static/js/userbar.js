// --------------------------------------------------------------------------------------
//
var insert_bar = function(json, status, xhr ) {
    var content = xhr.getResponseHeader('Content-Type');

    if( content.match(/json/) ) 
    {
        $('#placeholder').hide();
        if( json.signed_in == 1 ) {
            //$('#signedin').show();
            //$('#applications').show();
            //$('#signedout').hide();
            $('#SIN').show();
            $('#SOUT').hide();
            $('#email').text(json.email);

            // Inject API keys into explorer
            len = json.api_keys.length;
            for( var i = 0; i < len; i++ ) {
                apiExplorer.addApiKey( json.api_keys[i].name, json.api_keys[i].key );
            }
            apiExplorer.injectApiKeysIntoPage();
        } else {
            //$('#signedin').hide();
            //$('#signedout').show();
            $('#SIN').hide();
            $('#SOUT').show();
        }
    }
}

// ------------------------------------------------------------------------------

var bar_failure = function(text, status, xhr ) {
    $('#placeholder').html( 'Error fetching user information...' );
    $('#ERROR').show();
}

// ------------------------------------------------------------------------------
//
var populate_user_bar = function( doc ){

    var baseurl = doc.location.protocol + '//' + doc.location.host;

    var url = baseurl + '/developer/user-bar';

    $.ajax({
        url: url,
        type: 'GET',
        async: true,
        success:  function( text, status, xhr)  { insert_bar( text, status, xhr) },
        error:    function( xhr,  status, text) { bar_failure( xhr.responseText,  status, xhr) }
    });
}

// ------------------------------------------------------------------------------
//
$( document ).ready( populate_user_bar( document ) );

// ------------------------------------------------------------------------------
