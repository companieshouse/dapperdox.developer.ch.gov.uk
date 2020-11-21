Overlay: true

[[example]]
### Example

```
GET /user/profile HTTP/1.1
Host: https://identity.company-information.service.gov.uk
Authorization: Bearer 12397h2giu24g2o0781y3r9181-1r9uhf19fh13f98h1f:1fiubfv81g3f
```
```
HTTP/1.1 200 Found
Access-Control-Allow-Origin: *
Connection: close
Content-Type: application/json; charset=utf-8

{
    "surname"  : "users-surname",
    "forename" : "users-forename",
    "email"    : "user@somedomain.com",
    "id"       : "sdvojdfg9whege7r89wqyg02e7tr0134o",
    "locale"   : "en-GB"
}
```

