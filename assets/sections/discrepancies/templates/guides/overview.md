Navigation: Overview
SortOrder: 100

# Overview

Companies House Discrepancies service allows 3rd party software to report discrepancies to Companies House

Discrepancies initially exposes one API Service:

- `Persons with Significant Control`. This API provides the specific reporting functionality for discrepancies
 involving Persons with Significant Control. A report can be created, and multiple discrepancies
 can be added before submitting the report to Companies House.

# Authentication
Discrepancies requires software to integrate with Companies House OAuth 2.0 Service
and cannot be done with a simple API key using `Basic` authentication.

For a detailed guide on this integration see [Authenticating Web Server Apps with OAuth 2.0](https://developer-specs.company-information.service.gov.uk/companies-house-identity-service/guides/ServerWeb)

The Persons with Significant Control API will have additional security.
Users will be required to obtain the appropriate PSC Discrepancy scope and API endpoints
check that the end user has the appropriate permissions associated to their `client_id` and `client_secret`.
Please ask any Obliged Entities wishing to file via your software to contact Companies House
by emailing pscdiscrepancyapi@companieshouse.gov.uk and request that the appropriate permissions are associated
with their user credentials. This requirement does not apply in live sandbox.

## Scopes
All Discrepancies software will need to sign their users in to Companies House with one or more `scopes`.

- `https://identity.company-information.service.gov.uk/user/profile.read` is required
 for Discrepancies and grants permission to read the users profile data.

- `https://identity.company-information.service.gov.uk/psc-discrepancy-reports.write-full` is required
 for Persons with Significant Control submissions

Combining multiple scopes is done by space separating them as one string so the requested scope for Discrepancies
for Persons with Significant Control submissions should be:

- `https://identity.company-information.service.gov.uk/user/profile.read`
`https://api.company-information.service.gov.uk/psc-discrepancy-reports.write-full`

# Report Discrepancies

## Creating A Report
The first step in any Persons with Significant Control submission will be to create a report.
This is done with a POST request to `/psc-discrepancy-reports`.

## Creating Discrepancies
Once a report has been created, your software will have a `discrepancy-report-id` to use for creating discrepancies.
To create discrepancies using the Person with Significant Control API, your software will need to use the
`discrepancy-report-id` to construct the URL.

`/psc-discrepancy-reports/{discrepancy-report-id}/discrepancies`

Making a valid POST request to this URL will add the discrepancies to the report.

## Updating a Report

Once a report has been created it can be updated by making a `PUT` request to `/psc-discrepancy-reports`
where the request body sets the status field to `INCOMPLETE` e.g.

`PUT https://api.company-information.service.gov.uk/psc-discrepancy-reports/{discrepancy-report-id}`  with a request body:

```
{
    "status":"INCOMPLETE"
}
```

## Completing a Report
Once a report has one or more discrepancies added to it, it must be completed before it can be submitted to Companies House.
A report can be completed by making a `PUT` request to `/psc-discrepancy-reports`
where the request body sets the status field to `COMPLETE` e.g.

`PUT https://api.company-information.service.gov.uk/psc-discrepancy-reports/{discrepancy-report-id}` with a request body:

```
{
    "status":"COMPLETE"
}
```

Once a report has been completed, it can no longer be modified by the end user or any third-party software.
The discrepancies can no longer be changed either.

## Example
Each endpoint is documented with examples within the developer site.

# Testing

## Sandbox Environment
When testing any software that integrates with the Companies House Discrepancies service,
you will be able to test using our Sandbox environment.

- Sandbox API: `https://api-sandbox.company-information.service.gov.uk`
- Sandbox Identity/OAuth Service: `https://identity-sandbox.company-information.service.gov.uk`
- Sandbox Test Data API: `https://test-data-sandbox.company-information.service.gov.uk`

The services above allow all Discrepancy functions and related Public Data APIs functions
(such as `GET /company/{company_number}`) for test companies.

## Test API Clients
The Sandbox environment does not allow use of `Live` API clients that have been created in the Companies House Developer Hub.

In order to use the sandbox environment, you will need to create `Test` API clients and configure your software to use those instead.

This may include a test web client and test API key if your software uses both.
For instance, a web client to integrate with the OAuth service and API key to call public data functions.

## Test Data API
The Sandbox test data api allows test companies with Persons with Significant Control to be generated on demand for use in the sandbox environment. This service is not available in the Live environment.

# Moving To Live
Once your software has passed testing and you are ready to move to Live, there are a few things that will
need to change in your software. Ideally, these items will be configurable with properties files, environment variables,
database lookups or some other mechanism that does not require code changes:

- The Companies House API domain
- The Companies House Identity/OAuth Service domain
- Your Client ID and Client Secret combination
- Your API key

## Live Responses
In the Live environment, responses will not be mocked. This means that all submissions will be sent to Companies House
 for review and if valid will be accepted on to the public register.

