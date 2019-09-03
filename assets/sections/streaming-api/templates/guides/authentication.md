Navigation: Authentication
SortOrder: 200

# Authentication

## Register for an account

To be able to explore and use the the Companies House streaming API, you need
to [register](https://developer.companieshouse.gov.uk/developer/signin) a user
account with Companies House.

## Register your application and receive an API key

Visit the [Your Applications](https://developer.companieshouse.gov.uk/developer/applications)
page of the Companies House Developer Hub. This will show you the REST API and
streaming API applications you have already registered, and allow you to
register further applications.

Applications that are to use the streaming API must be registered as such, the
REST API and streaming API keys are not interchangable.

### Register a new application

To register a new application, click the **Register an application** button.

You will now be asked which type of application you are registering, choose
**Streaming API**. 

Fill in your **Application name**, giving it a meaninful description and,
if appropriate, a list of **Restricted IPs** and when you're done, click **Register**.

The hub will register your application, and provide you with a unique
streaming API key that you will use to authenticate your application every
time you connect to a streaming API.

## Using Basic authentication

When connecting to the streaming API, you authenticate using [`Basic`](https://en.wikipedia.org/wiki/Basic_access_authentication) 
authentication, which is wildly supported by HTTP client libraries and command
line tools.

To authorise using Basic authentication, the client sends the server an
`Authorization` [HTTP header](https://tools.ietf.org/html/rfc7617#section-2)
specifying a scheme type of `Basic` and a value that is constructed as follows:

1. An ASCII colon '`:`' is appended to the end of the streaming API key
2. Basic-credentials are created by encoding this concatenated sequence by
   using Base64 [RFC4648](https://tools.ietf.org/html/rfc4648#section-4)
   into a sequence of US-ASCII characters [RFC4648](https://tools.ietf.org/html/rfc0020).

Given an example streaming API key of `a-streaming-api-key`, the complete
HTTP authorization header would be:

```http
Authorization: Basic YS1zdHJlYW1pbmctYXBpLWtleTo==
```

Note that you will get a different and invalid base64 encoded value if you
ommit the colon '`:`' from the end of the API key before encoding.

The following curl request authenticates with `Basic` authentication:

```
curl -v -u a-streaming-api-key: "https://streaming-api.companieshouse.gov.uk/companies?timepoint=187124872486"
```
