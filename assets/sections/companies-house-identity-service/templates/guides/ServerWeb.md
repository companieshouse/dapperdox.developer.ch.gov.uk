Navigation: OAuth 2.0 Overview/OAuth 2.0 Server Side Web Apps
SortOrder: 305

# Authenticating Web Server Apps with OAuth 2.0

Interaction with some Companies House API functionality requires oauth2 authorisation.
In web server apps, interaction with the Companies House API requires end-user involvement
for authentication to prove their identity before the API will allow access.


## Overview

In a web server process flow, there must be end user
involvement and the process flow is as follows:

### Developer setup

- The developer registers an `Application` with the [Companies House Developer Hub](https://developer.company-information.service.gov.uk).
- The developer then creates a web client for their application obtaining a `client_id` and a `client_secret` which must be stored securely by the developer.
- The web server application must be configured to use this `client_id` and `client_secret` combination for interactions with the Companies House OAuth 2.0 service.

### Initiating the OAuth Web Server Flow

- When the web server wants to sign an end user in with their Companies House account it redirects the users browser to the `/oauth2/authorise` endpoint with the developers `client_id` and other details including the requested scope(s) and a registered `redirect_uri`.
- The end user signs in to their Companies House account and provides a Company Auth Code if any requested scopes contain a specific company number.
- The end user will be prompted to grant access for the `Application` to perform certain actions on their behalf.
- When the end user grants this permission they they will be redirected to the `redirect_uri` provided with a `code` parameter to be used in the next stage.

### Handling the Redirect back
- The web server can then use the `code` to exchange for the users `access_token` and `refresh_token` by making a `POST` request to the `/oauth/token` endpoint.
- This request is not done via a browser but directly from the web server to the Companies House OAuth 2.0 service.
- This request body includes the `code`, the developers `client_id`, `client_secret` and some other relevant information. The `grant_type` must be set to `authorization_code` to exchange an authorization code for an access token.
- The Companies House OAuth 2.0 service verifies this request, and if access is permitted, responds with access and refresh tokens.
- The application uses this access token when making requests to the Companies House API.

### Verifying the access token
- The web server can verify the access token before using it against other Companies House APIs.
- To verify the access token the web server should make another request directly (not in the users browser) to the `/oauth/verify` endpoint.

### Refreshing an access token
- When the access token expires, the application can use the `/oauth/token` endpoint again to exchange the refresh token for a new access token. The `grant_type` must be set to `refresh_token` to exchange an refresh token for an access token.

## Example

Each endpoint is documented with examples within thie developer site.

Companies House have also written an example [Third Party Test Harness](https://github.com/companieshouse/third-party-test-harness) application that shows how a web server application can interact with the Companies House OAuth 2.0 service. The README of this GitHub repository details how to configure and run the test harness.
