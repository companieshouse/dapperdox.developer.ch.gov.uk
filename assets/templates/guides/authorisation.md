Title: Authorisation
Navigation: Authorisation
SortOrder: 50

Authorisation
=============

API key authentication
----------------------

The Companies House API requires authentication credentials, in the form
of an API key, to be sent with each request.

To obtain an API key, go to [Your applications](/developer/applications)
and register the application with the Companies House Developer Hub as
an `API Key` application. This will allocate a unique key to the
application which can be sent with any `GET` request for a public
resource served by the Companies House API.

### Sending the API key

The Companies House API uses [HTTP Basic
Authentication](http://en.wikipedia.org/wiki/Basic_access_authentication)
to transmit an API key between the client application and the server.
Basic authentication is usually made up of a username and password pair;
the Companies House API takes the username as the API key and ignores
the password, so can be left blank.

Example
-------

### HTTP Basic Authentication

For an API key of my\_api\_key, the following curl request demonstrates
the setting of the `Authorization` HTTP request header, as defined by
[RFC2617](https://tools.ietf.org/html/rfc2617).

    curl -XGET -u my_api_key: https://api.companieshouse.gov.uk/company/00000006

    GET /company/00000006 HTTP/1.1
    Host: api.companieshouse.gov.uk
    Authorization: Basic bXlfYXBpX2tleTo=

