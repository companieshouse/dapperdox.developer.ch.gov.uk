Navigation: API Filing Overview
SortOrder: 100

# Overview

Companies House API Filing service allows 3rd party software to file certain forms and change certain company data with Companies House.

API Filing initially exposes two API services:

- `Transactions API`. This API provides the generic model that encapsulates all other API Filing services. A transaction is best thought of as an envelope for one or more data changes or forms.
- `Registered Office Addres (ROA) API`. This API provides the specific ROA data change functionality. An ROA data change can be added to a transaction before the transaction is submitted to Companies House.

# Authentication

API Filing requires sofotware to integrate with Companies House OAuth 2.0 Service and cannot be done with a simple API key using `Basic` authentication.

For a detailed guide on this integration see [Authenticating Web Server Apps with OAuth 2.0](/companies-house-identity-service/guides/ServerWeb)

## Scopes

All API Filing software will need to sign their users in to Companies House with one or more `scopes`.

- `https://identity.company-information.service.gov.uk/user/profile.read` is required for API Filing and grants permission to read the users profile data.

Depending on the filing functionality the list of scopes may change however for the ROA change the following scope will also be required:

- `https://api.company-information.service.gov.uk/company/{company_number}/registered-office-address.update`

Note that the `{company_number}` placeholder must be filled in with an actual company number e/g/ for company `00000001` this scope would be
`https://api.company-information.service.gov.uk/company/00000001/registered-office-address.update`.

Combining multiple scopes is done by space separating them as one string so the requested scope for API Filing an ROA data change for company `00000001` should request the scope:

- `https://identity.company-information.service.gov.uk/user/profile.read https://api.company-information.service.gov.uk/company/00000001/registered-office-address.update`


# API Filing Process 101

## Creating A Transaction

The first step in any API Filing submission will be to create a transaction. This is done with a `POST` request to `/transactions`.

This request takes an optional `company_number` parameter. The company number provided must match the company number used in the requested scope when signing the user in to Companies House OAuth 2.0 Service. If it does not then the request will be unauthorized.

This parameter is optional for future use cases where the company number may not be applicable (e.g. for filing an incorporation) however if the data change relates to an existing company this field must be provided.

## Adding an API Filing Resource

Once a transaction has been created your software will have a `transaction_id` to use for creating data change or form resources such as the ROA data change resource.

To create an ROA data change resource using the ROA API your software will need to use the `transaction_id` to to construct the URI

`/transactions/{transaction_id}/registered-office-address`

Making a valid `POST` request to this URI will then add the ROA data change resource to the transaction.

This URL can be used to make changes to the ROA data change resource with a `PUT` request to make further changes before moving on to the next step to close the transaction.

## Closing A Transaction

Once a transaction has one or more data change or form resources added to it it must be `closed` to submit these data changes and forms to Companies House.

A transaction can be closed by making a `PUT` request to `/transactions/{transaction_id}` where the request body sets the `status` field to `closed e.g.

`PUT https://api.company-information.service.gov.uk/transactions/000000000000000001` with a request body

```
{
    "status": "closed"
}
```

Once a transaction has been closed it can no longer be modified by the end user or any third party software. The data change or filing resources can no longer be changed either.

Note that the end user will receive an email from Companies House confirming their submission.

## Accept/Reject Status

After a transactions has been `closed` and submitted to Companies House the data changes and forms it contains it may be accepted or rejected.

Your software can check for accept/reject updates by making a `GET` request to `/transactions/{transaction_id}` and checking the data inside the read only `filings` object.

Note that the end user will receive an email from Companies House confirming the status when it has been processed.

# Example

Each endpoint is documented with examples within thie developer site.

Companies House have also written an example [Third Party Test Harness](https://github.com/companieshouse/third-party-test-harness) application that shows how a web server application can interact with the Companies House OAuth 2.0 service then file an ROA change using these APIs. The README of this GitHub repository details how to configure and run the test harness.

# Testing

## Sandbox Environment

When testing any software that integrates with the Companies House API Filing services you will be able to test using our Sandbox environment.

Sandbox API: `https://api-sandbox.company-information.service.gov.uk`
Sandbox Identity/OAuth Service: `https://identity-sandbox.company-information.service.gov.uk`
Sandbox Test Data API: `https://test-data-sandbox.company-information.service.gov.uk`

The services above allow all API Filing functions and related Public Data APIs functions (such as `GET /company/{company_number}`) for test companies.

## Test API Clients

The sandbox environment does not allow use of `Live` API clients that have been created in the Companies House Developer Hub.

In order to use the sandbox environment you will need to create `Test` API clients and configure your software to use those instead.

This may include a test web client and a test API key if your software uses both e.g. web client to integrate with the oauth service and API key to call public data functions.

## Test Data API

The sandbox test data api allows test companies to be generated on demand for use in the sandbox environment. This service is not available in the live environment.

## Mock Responses

The sandbox environment will automatically respond to all test filing submissions and update the filings status to either `accepted` or, in specific cases documented below `rejected` with specific reject reasons.

For ROA data change submissions made using the Transactions and ROA API's the following scenarios:

- Postcode matches one of the postcodes of a Companies House office ("CF143UZ", "BT28BG", "SW1H9EX" or "EH39FF")

All other submissions will receive a mock response status of `accepted`.

# Moving To Live

Once your software has passed testing and you are ready to move to live there are a few things that will need to change in your software. Ideally these items will be configurable with properties files, environment variables, database lookups or some other mechanism that does not require code changes:

- The Companies House API domain
- The Companies House Identity/OAuth Service domain
- Your Client ID and Client Secret combination
- Your API key


## Live Responses

In the Live environment responses will not be mocked. This means that all submissions will be sent to Compaies House for review and if valid will be accepted on to the public register.

Some submissions may require manual inspection which will add a delay to processing. Your software may want to check for accept/reject status by polling the status of the filing using `GET /transactions/{transaction_id}`. While this is perfectly fine and expected please be sure to obey our rate limiting rules when polling APIs for responses.
