Overlay: true

[[request-body]]
The created transaction will be assigned to the user whose `access_token` was used to authorise the API call, and
if a `company_number` is supplied, will be linked to that company, allowing the company's data to be modified.
In this case the `company_number` must match the authorising access_token's `company filing permission` scope,
otherwise the `create` will be denied.

If no `company_number` is provided in the `create` request, then the transaction will not be assigned to a
company, and therefore will not be able to participate in the modification of company data. Such a transaction
could be used to incorporate a new company or to handle other data interactions with Companies House that are not
directly company related.
