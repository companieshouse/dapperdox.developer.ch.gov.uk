Overlay: true

[[description]]
This operation is the first step in server-side web application authentication.

This operation takes the user through a web authentication journey resulting in an
authorisation code being returned to the server-side web application. The web application then performs a second
step of [exchanging this authorisation code for an access token](/companies-house-identity-service/reference/authentication/obtain-access-token).

[[example]]
### Example

```
GET /oauth2/authorisation?scope=https://identity.company-information.service.gov.uk/user/profile.read%20https://api.company-information.service.gov.uk/company/00000000/registered-office-address.update&redirect_uri=https://somewhere.example.com/oauthcallback&response_type=code&client_id=6ghe7938zhd821hf&state=some_application_state_string HTTP/1.1
```

#### Handling the response

The response is sent to the `redirect_uri` passed in the authorisation request.

The `redirect_uri` will be of a server page that will decode the response and issue an
[access token exchange](/companies-house-identity-service/reference/authentication/obtain-access-token) on the authorisation `code`.

The size of the `code` values may vary in size and be increased in the future.

```
GET https://somewhere.example.com/oauthcallback&code=987124y8g5r897t1t9y8b24t967g13-wzy&state=some_application_state_string HTTP/1.1
```
