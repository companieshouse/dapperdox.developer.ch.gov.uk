Navigation: stuff/Getting started
SortOrder: 100

# Getting started with the Payment Platform

The Companies House Payment Platform allows applications to take payment
from a user for fee-bearing transactions that the application has submitted to Companies House.

A typical application engagement flow would be:

1. The application closed the requisite `transaction` by setting its status to `closed`.
2. If the `transaction` is fee-bearing,  a `202 Accepted` response will be received, with an `X-Payment-Required` header directing the application to the Payment Platform to begin a payment session.
3. The application calls the platform to create a payment session, and redirects the user to the platform to begin the engagement.
4. Once payment has been taken the platform redirects the user back to the application, using the application supplied `redirect_uri`.
5. The application must verify the state of the payment, success or failure, before proceeding by making an API call to the platform.

## Typical flow diagram
![Payment sequence diagram](/payment-api/static/images/PaymentPlatformSequence.png)


**Note** TODO - in some cases (non browser based application) there may be no website to return to, so there needs to be a special redirect URN that means 'close the browser'. This should follow the same end-of-journey integrations as OAuth2 (redirect to localhost etc).

## Creating a payment session

The first step in a payment process is the creation of a **payment session**. This is achieved
by `POST`ing to the `create` `payments` API, passing it the URI of the `transaction` resource that
is to be paid for, along with the application's return URI to which the platform should redirect
the user on completion: 
```
POST /payments HTTP/1.1
Host: payments.companieshouse.gov.uk
Authorization: Bearer wfiuht0384fg3fouhqwef0q87gt13p49q8ghqe09fuhq397tgh13p94qg8h3q9g7

{
    "redirect_uri": "https://client.web.domain/payment-complete-callback",
    "resource": "/transactions/123456-123456-123456-123456",
    "state": "application-nonce-value"
}
```

If sucessful, the Payment Platform will create a `payments` resource and return a `201 Created`
response along with the `payments` resource. The resource contains a number of URIs which help
applications drive the remainder of the payment journey (the example resource here has been
trimmed for brevity):

```javascript
{
    "ammount": "23.50",
    "links": {
        "journey": "https://payments.companieshouse.gov.uk/payments/149871-112923-1234782/pay",
        "resource": "/transactions/123456-123456-123456-123456",
        "self": "/payments/149871232-112986123-1246234782"
    },
    "status": "in-progress"
}
```

An open payment session will be valid for a period of one hour, after which time it
will expire. After that point, requests for the payment session `payments` resource
`/payments/{id}` will return `404 Not Found`.


## Taking payment from the user

To initiate the web journey through which the user will interact to make the payment,
the application must redirect the user's browser to the `links.journey` URL returned
in the `payments` resource.

Once the payment is complete, the `links.journey` member will no longer be vaild or
returned in the `payments` resource.


## Verifying the payment

On completion of a payment journey, the Payment Platform will redirect
the user's browser back to the `redirect_uri` supplied when the payment session
was created.

There are two levels of verification that applications must perform on receiving a
hand-back from the Payment Platform:

1. The application must ensure that the returned `state` matches the nonce
sent by the application to the Payment Platform during hand-off, and that the application
has received it only once during a hand-back. This is the application's protection
against [CSRF](https://owasp.org/www-community/attacks/csrf).

2. If the first step passes, the application must validate the status of the payment
by fetching the `payments` resource and inspecting its `status` member (its URL was
returned as the `links.self` member of the `payments` resource returned on creation).

```
GET /payments/149871232-112986123-1246234782 HTTP/1.1
Host: payments.companieshouse.gov.uk
Authorization: Bearer wfiuht0384fg3fouhqwef0q87gt13p49q8ghqe09fuhq397tgh13p94qg8h3q9g7

{
    "ammount": "23.50",
    "links": {
        "resource": "/transactions/123456-123456-123456-123456",
        "self": "/payments/149871232-112986123-1246234782"
    },
    "payment_method": "credit-card",
    "status": "complete"
}
```

## Dealing with failures

On verifying a completed payment, if the payment session `payments` resource has a `status`
of `failed`, the `errors` sub-document should be inspected to discover why the
failure occurred.

There are several reasons why the payment may have failed.

- User cancelled
- Insufficient funds
- Payment error *(downstream at GovPay or Barclays etc)*


If a GET request for the payment session resurce returns the HTTP status code
`404 Not Found`, then this indicates that the payment session expired before
the user completed the payment process.


## Authorisation

Access to the Payment Platform is authorised through an OAuth2 `access_token`. The 
`access_token` must have permission to read and modify the fee-bearing `transaction`
that is being paid for.

