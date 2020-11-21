Overlay: true

[[request-end]]
#### Exchange an authorization code
To exchange an authorization code for an access token, send a "fetch access token" API
request containing the following parameters:

```
POST /oauth2/token HTTP/1.1

grant_type=authorization_code&
code=authorization-code&
client_id=your-client-id&
client_secret=your-client-secret&
redirect_uri=application-redirect-uri
```

This will return an accessToken resource, including a `refresh_token` that can be used
offline to aquire a new access_token, once the access_token has expired.

#### Refreshing an access token
When an access token has expired, you can generate a new token without any user involvement
by sending the refresh token in a request to the "fetch access token" API:

```
POST /oauth2/token HTTP/1.1

grant_type=refresh_token&
refresh_token=a_refresh_token&
client_id=your-client-id&
client_secret=your-client-secret
```

The accessToken resource returned from a refresh request will not contain a `refresh_token`.

[[example]]

### Example - Request an access token

```
POST /oauth2/token HTTP/1.1
Host: https://identity.company-information.service.gov.uk
Content-Type: application/x-www-form-urlencoded
Content-Length: 216

code=78hfbvkwe9823bvkjsbw99bgsdkjb923&amp;
client_id=6ghe7938zhd821hf-domain&amp;
client_secret=<client_secret>&amp;
redirect_uri=https://somewhere.example.com/oauthcallback/token&amp;
grant_type=authorization_code
```
```
HTTP/1.1 200 Found
Access-Control-Allow-Origin: *
Connection: close
Content-Type: application/json; charset=utf-8

{
    "access_token":  "12397h2giu24g2o0781y3r9181-1r9uhf19fh13f98h1f:1fiubfv81g3f",
    "expires_in" :   "3600",
    "token_type" :   "Bearer",
    "refresh_token": "vdi9uwerg0y34t-1rtouygb2frv89tgtg13g13g-1grvyb1f49o1b"
}
```

