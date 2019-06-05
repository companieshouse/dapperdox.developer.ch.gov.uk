Title: API versioning
Navigation: API versioning
SortOrder: 80

# API versioning

The Companies House API is versioned using MIME types and content negotiation.

You can request a specific version of a resource using the `Accept` request header,
and the resource version is returned in the `Content-Type` response header.

Each resource is versioned independently - there is no global API version number.

_Notes_:

* the MIME types and resource examples used here are for demonstration
purposes only, you should consult the API resource documentation for up to date
MIME types
* existing API resources will be frozen at `v0` and will be maintained for 3 months

#### Example

This request returns the latest version (1.1) of a Company Profile resource:

```
GET /company/12345678 HTTP/1.1
Accept: application/json

HTTP/1.1 200 OK
Content-Type: application/x.companieshouse.company-profile+json; version=1.1

{
  "company_number": "12345678"
}
```

### Version changes

Version numbers will be incremented for breaking changes, for example:

- removing or renaming a field
- changing a field data type
- changing the structure of a nested field

Non-breaking changes will not increment the version number, for example:

- adding additional fields

### Default versions

The default behaviour is to return the latest version of a resource, when:

* no `Accept` header is provided with the request
* the `Accept` header is set to `application/json` or `*/*`

### HTTP response codes

For a valid `Accept` header, the HTTP response codes are specified in the
API endpoint documentation.

If the `Accept` header type or version is invalid, a `406` response is returned:

```
GET /company/12345678 HTTP/1.1
Accept: application/vnd.companieshouse.company-profile+json; version=999

HTTP/1.1 406 Not Acceptable
```

If the `Accept` header MIME type has recently expired, say version 0, then a `410` response is returned:

```
GET /company/12345678 HTTP/1.1
Accept: application/vnd.companieshouse.company-profile+json; version=0

HTTP/1.1 410 Gone
```

### Deprecation

When a resource version is deprecated its expiry date will be provided in a
`CH-Expiry-Date` response header.

This provides the date the resource version will become unavailable,
which will typically be three months after the deprecation date.

For example:

```
GET /company/12345678 HTTP/1.1
Accept: application/vnd.companieshouse.company-profile+json; version=1

HTTP/1.1 200 OK
Content-Type: application/vnd.companieshouse.company-profile+json; version=1
CH-Expiry-Date: 2016-01-01; rel=application/vnd.companieshouse.company-profile+json; version=1

{
  "company_number": "12345678"
}
```

The `rel` parameter specifies which MIME type has been deprecated.



## This isn't versioning, but is a related resource control scheme

### Partial 

In some circumstances, a resource may need to be partially created or updated (for example, a resource that is being
saved to be resumed at a later date). The resource members that have been submitted should still be validated in most
circumstances, and this is controlled through the `validation` content type parameter.

The `validation` parameter can take the following values:
- `full` (the default)
- `partial`
- `none`

```
POST /company/12345678 HTTP/1.1
Content-Type: application/vnd.companieshouse.company-profile+json; version=1; validation=partial

{
  "company_number": "12345678"
}
```
