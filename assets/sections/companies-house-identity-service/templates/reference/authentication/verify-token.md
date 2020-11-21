Overlay: true

[[example]]

### Example

```
POST /oauth2/verify?access-token=12397h2giu24g2o0781y3r9181-1r9uhf19fh13f98h1f:1fiubfv81g3f HTTP/1.1
Host: https://identity.company-information.service.gov.uk
```
```
HTTP/1.1 200 Found
Access-Control-Allow-Origin: *
Connection: close
Content-Type: application/json; charset=utf-8

{
    "application": "6ghe7938zhd821hf-domain",
    "expires_in" : "1429",
    "scope": "https://identity.company-information.service.gov.uk/user/profile.read https://api.company-information.service.gov.uk/company/00000000/registered-office-address.update",
    "user_id": "sdvojdfg9whege7r89wqyg02e7tr0134o"
}
```

