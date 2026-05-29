Navigation: Overview
SortOrder: 100

# Strike-off Partner Objections API overview

This API allows partner organisations to create, read, and withdraw strike-off objections asynchronously.

### Testing in the sandbox

Before integrating with the live production environment, partner organisations should validate their integration in the sandbox.
You can use the [Sandbox Test Data Generator API](https://developer-specs.company-information.service.gov.uk/sandbox-test-data-generator-api/reference/company-test-data/create?v=latest) to create a mock company in an active-proposal-to-strike-off state, to then safely test a mock response. Alternatively you can also mock unsuccessful responses.

### Prerequisites

Before creating an objection using this API, partner organisations must:
1. Use the [Companies House Streaming API](https://developer-specs.company-information.service.gov.uk/streaming-api/guides/overview) to identify target companies.
2. Call the [Companies House Public Data API](https://developer-specs.company-information.service.gov.uk/companies-house-public-data-api/reference) to look up the up to date company details and ensure it is in an active proposal to strike off.

Once identification and checks are complete, you may use this API to submit an objection, look up details of an objection submitted via this API, or withdraw bulk objections created by the same partner organisation.

## What this API is for

Use this API when your organisation needs to:

- submit an objection for a company
- retrieve objection status and details
- submit a bulk withdrawal request for active objections
- retrieve withdrawal request status

This API is asynchronous. Submission endpoints return a created/accepted response first, and processing continues in the background.

## Core endpoints

### Create objection

`POST /company/{company_number}/strike-off-partner-objections`

Creates a new objection for a company and returns an `objection_id`.

### Get objection by ID

`GET /company/{company_number}/strike-off-partner-objections/{objection_id}`

Returns the latest state of the objection, including processing status and failure reason (if applicable).

### Withdraw all objections

`POST /company/{company_number}/strike-off-partner-objections-withdrawals`

Submits a request to withdraw all active objections for the source client and returns a `withdrawal_id`.

### Get withdrawal by ID

`GET /company/{company_number}/strike-off-partner-objections-withdrawals/{withdrawal_id}`

Returns the latest processing status for a withdrawal request.

## Callback updates

Processing outcomes are provided asynchronously via callback payloads.

In Swagger 2.0 documentation, this is represented as a normal endpoint:

`POST /partner-webhooks/callback`

The callback payload identifies the processed resource (`objection` or `withdrawal`) and includes the resource URI for follow-up retrieval.

## Authentication

All endpoints require API key authentication using the `Authorization` header.

## Environments

- Production: `https://api.company-information.service.gov.uk`
- Sandbox: `https://api-sandbox.company-information.service.gov.uk`