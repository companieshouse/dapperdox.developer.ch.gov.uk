# Dapperdox base documentation

## What is this repo used for ?

The main task implemented by this repo is to source the specs and to render them as inspectable documentation on the 2 dev portals:
- public:  https://developer-specs.company-information.service.gov.uk/
- private: https://developer-specs.cidev.aws.chdev.org/

## Which specs are registered ?

The specs which are sourced and rendered are stored in separate repos, which are referenced, as submodules, inside the [specs/](https://github.com/companieshouse/dapperdox.developer.ch.gov.uk/tree/9571799d47f5cf0214ad06bf334e0272539a0bf2/specs) dir.

Currently these 4:

- https://github.com/companieshouse/api.ch.gov.uk-specifications
- https://github.com/companieshouse/private.api.ch.gov.uk-specifications
- https://github.com/companieshouse/document.api.ch.gov.uk-specifications
- https://github.com/companieshouse/account.ch.gov.uk-specifications

## Public and Private portals

Some of the specs are published on the public portal, some others are instead accessible only on the private web site.

Not all the json files which are listed in a `-specifications` repo will then be automatically available on the public portal.

Some might be missing (ex. at the time of writing:
[company-accounts.json](https://github.com/companieshouse/api.ch.gov.uk-specifications/blob/e7ed000/swagger-2.0/spec/company-accounts.json))

The list of public specs rendered can be quickly checked, for example, looking at stderr:

    2022/09/21 06:53:23 Registering specifications
    2022/09/21 06:53:23 Importing OpenAPI specifications from http://127.0.0.1:31717/api.ch.gov.uk-specifications/swagger-2.0/spec/streaming.json
    2022/09/21 06:53:23 [XVlBzgbaiCMRAjWwhTHc] [info] GET /api.ch.gov.uk-specifications/swagger-2.0/spec/streaming.json (200, 140.449µs)
    2022/09/21 06:53:23 [tcuAxhxKQFDaFpLSjFbc] [info] GET /api.ch.gov.uk-specifications/swagger-2.0/spec/stream.json (200, 68.141µs)
    2022/09/21 06:53:23 [XoEFfRsWxPLDnJObCsNV] [info] GET /api.ch.gov.uk-specifications/swagger-2.0/models/stream/insolvencyCases.json (200, 23.018µs)
    2022/09/21 06:53:23 [lgTeMaPEZQleQYhYzRyW] [info] GET /api.ch.gov.uk-specifications/swagger-2.0/models/stream/streamEnvelope.json (200, 91.602µs)
    2022/09/21 06:53:23 [JjPjzpfRFEgmotaFetHs] [info] GET /api.ch.gov.uk-specifications/swagger-2.0/spec/insolvency.json (200, 58.905µs)
    2022/09/21 06:53:23 [bZRjxAwnwekrBEmfdzdc] [info] GET /api.ch.gov.uk-specifications/swagger-2.0/models/stream/charges.json (200, 19.562µs)
    2022/09/21 06:53:23 [EkXBAkjQZLCtTMtTCoaN] [info] GET /api.ch.gov.uk-specifications/swagger-2.0/spec/charges.json (200, 62.527µs)
    2022/09/21 06:53:23 [atyyiNKAReKJyiXJrscc] [info] GET /api.ch.gov.uk-specifications/swagger-2.0/models/stream/officerAppointments.json (200, 22.303µs)
    2022/09/21 06:53:23 [tNswYNsGRussVmaozFZB] [info] GET /api.ch.gov.uk-specifications/swagger-2.0/spec/companyOfficerList.json (200, 74.478µs)
    2022/09/21 06:53:23 [sbOJiFQGZsnwTKSmVoiG] [info] GET /api.ch.gov.uk-specifications/swagger-2.0/models/stream/psc.json (200, 20.942µs)
    2022/09/21 06:53:23 [LOpbUOpEdKupdOMeRVja] [info] GET /api.ch.gov.uk-specifications/swagger-2.0/spec/pscModels.json (200, 85.699µs)
    2022/09/21 06:53:23 [RzLNTXYeUCWKsXbGyRAO] [info] GET /api.ch.gov.uk-specifications/swagger-2.0/models/stream/disqualifiedOfficers.json (200, 21.35µs)
    2022/09/21 06:53:23 [mBTvKSJfjzaLbtZsyMGe] [info] GET /api.ch.gov.uk-specifications/swagger-2.0/spec/disqualifiedOfficersStream.json (200, 37.877µs)
    2022/09/21 06:53:23 [uDtRzQMDQiYCOhgHOvgS] [info] GET /api.ch.gov.uk-specifications/swagger-2.0/spec/disqualifications.json (200, 58.675µs)
    2022/09/21 06:53:23 [eycJPJHYNufNjJhhjUVR] [info] GET /api.ch.gov.uk-specifications/swagger-2.0/models/stream/companyProfile.json (200, 19.365µs)
    2022/09/21 06:53:23 [uSqfgqVMkPYVkURUpiFv] [info] GET /api.ch.gov.uk-specifications/swagger-2.0/spec/companyProfile.json (200, 63.371µs)
    2022/09/21 06:53:23 [IZRgBmyArKCtzkjkZIva] [info] GET /api.ch.gov.uk-specifications/swagger-2.0/models/stream/filingHistory.json (200, 25.88µs)
    2022/09/21 06:53:23 [BjMkXVbWGvbqzgexyALB] [info] GET /api.ch.gov.uk-specifications/swagger-2.0/spec/filingHistory.json (200, 61.178µs)
    2022/09/21 06:53:23 Importing OpenAPI specifications from http://127.0.0.1:31717/api.ch.gov.uk-specifications/swagger-2.0/spec/swagger.json
    2022/09/21 06:53:23 [sdjSGpngCwFkDifIBuuf] [info] GET /api.ch.gov.uk-specifications/swagger-2.0/spec/swagger.json (200, 59.246µs)
    2022/09/21 06:53:23 [FMoWdiTskZoQJMqrTICT] [info] GET /api.ch.gov.uk-specifications/swagger-2.0/spec/filingHistory.json (200, 67.826µs)
    2022/09/21 06:53:23 [ojIYxyeSxZyfroRODMbN] [info] GET /api.ch.gov.uk-specifications/swagger-2.0/spec/errorModel.json (200, 30.363µs)
    2022/09/21 06:53:23 [DRZnPNRWCJPMHDtJmHAY] [info] GET /api.ch.gov.uk-specifications/swagger-2.0/spec/companyRegisters.json (200, 76.599µs)
    2022/09/21 06:53:23 [ORsUfUMApsVgzHblmYYt] [info] GET /api.ch.gov.uk-specifications/swagger-2.0/spec/search-companies.json (200, 80.662µs)
    2022/09/21 06:53:23 [EjVgwfFbbGGcnqbaEREu] [info] GET /api.ch.gov.uk-specifications/swagger-2.0/spec/psc.json (200, 64.776µs)
    2022/09/21 06:53:23 [nUZjQXmZOtaRLUtmYgmS] [info] GET /api.ch.gov.uk-specifications/swagger-2.0/spec/pscModels.json (200, 92.646µs)
    2022/09/21 06:53:23 [VYBADDvoxIfsfgPyCKmx] [info] GET /api.ch.gov.uk-specifications/swagger-2.0/spec/exemptions.json (200, 62.879µs)
    2022/09/21 06:53:23 [IubeYTNDtjAyRRDedMiy] [info] GET /api.ch.gov.uk-specifications/swagger-2.0/spec/companyOfficerList.json (200, 88.991µs)
    2022/09/21 06:53:23 [LprucjiOgjhYeVwBTCML] [info] GET /api.ch.gov.uk-specifications/swagger-2.0/spec/officerAppointmentList.json (200, 65.584µs)
    2022/09/21 06:53:23 [frDGXqwpzwVGqMZcLVCx] [info] GET /api.ch.gov.uk-specifications/swagger-2.0/spec/search.json (200, 75.344µs)
    2022/09/21 06:53:23 [aSJlDSYEofkkEYeqkKHq] [info] GET /api.ch.gov.uk-specifications/swagger-2.0/spec/companyAddress.json (200, 98.094µs)
    2022/09/21 06:53:23 [gBpnbPbgHMLUIDjUMmpB] [info] GET /api.ch.gov.uk-specifications/swagger-2.0/models/registeredOfficeAddress.json (200, 45.178µs)
    2022/09/21 06:53:23 [HCSjMJjxzuaiIsNBakqS] [info] GET /api.ch.gov.uk-specifications/swagger-2.0/models/genericModels.json (200, 19.678µs)
    2022/09/21 06:53:23 [wQpOQgNczgaczAInLqLI] [info] GET /api.ch.gov.uk-specifications/swagger-2.0/spec/disqualifications.json (200, 60.604µs)
    2022/09/21 06:53:23 [bAatLYHdaopovFOkqIex] [info] GET /api.ch.gov.uk-specifications/swagger-2.0/spec/charges.json (200, 59.325µs)
    2022/09/21 06:53:23 [sFzXzrlcztxcdJJFuyZH] [info] GET /api.ch.gov.uk-specifications/swagger-2.0/spec/companyUKEstablishments.json (200, 44.983µs)
    2022/09/21 06:53:23 [RCovgpVvlGsXalGqARmn] [info] GET /api.ch.gov.uk-specifications/swagger-2.0/spec/insolvency.json (200, 107.879µs)
    2022/09/21 06:53:23 [eBZBFelhXkzzfNaVtAyy] [info] GET /api.ch.gov.uk-specifications/swagger-2.0/spec/companyProfile.json (200, 67.951µs)
    2022/09/21 06:53:23 Importing OpenAPI specifications from http://127.0.0.1:31717/document.api.ch.gov.uk-specifications/swagger-2.0/spec/swagger.json
    2022/09/21 06:53:23 [qWzKqQFbucqNJYWRncGK] [info] GET /document.api.ch.gov.uk-specifications/swagger-2.0/spec/swagger.json (200, 85.504µs)
    2022/09/21 06:53:23 Importing OpenAPI specifications from http://127.0.0.1:31717/account.ch.gov.uk-specifications/swagger-2.0/identity-public.json
    2022/09/21 06:53:23 [KLdTkNyoCSfkFohsVVxS] [info] GET /account.ch.gov.uk-specifications/swagger-2.0/identity-public.json (200, 67.573µs)
    2022/09/21 06:53:23 Importing OpenAPI specifications from http://127.0.0.1:31717/api.ch.gov.uk-specifications/swagger-2.0/spec/filings-public.json
    2022/09/21 06:53:23 [AZWEXejhAquXdaaaZlRH] [info] GET /api.ch.gov.uk-specifications/swagger-2.0/spec/filings-public.json (200, 35.956µs)
    2022/09/21 06:53:23 [oNXvpayoSsqcnCTuGZam] [info] GET /api.ch.gov.uk-specifications/swagger-2.0/spec/companyAddress.json (200, 67.676µs)
    2022/09/21 06:53:23 [CToZvPynaEphIdXaKUaq] [info] GET /api.ch.gov.uk-specifications/swagger-2.0/models/registeredOfficeAddress.json (200, 59.374µs)
    2022/09/21 06:53:23 [mBdtZtcOfFSPqKXSLEfZ] [info] GET /api.ch.gov.uk-specifications/swagger-2.0/models/genericModels.json (200, 19.094µs)
    2022/09/21 06:53:23 [APaJzldaUEdhITGHvBrQ] [info] GET /api.ch.gov.uk-specifications/swagger-2.0/spec/insolvency.json (200, 74.153µs)
    2022/09/21 06:53:23 [PqWARPXPtPVGNpdGERwV] [info] GET /api.ch.gov.uk-specifications/swagger-2.0/models/errors.json (200, 27.957µs)
    2022/09/21 06:53:23 [hGCMdfLitTqwLUecgOcz] [info] GET /api.ch.gov.uk-specifications/swagger-2.0/spec/transactions.json (200, 62.257µs)
    2022/09/21 06:53:23 [XTbRMGxqPexOUAbUdQrI] [info] GET /api.ch.gov.uk-specifications/swagger-2.0/models/transactions.json (200, 50.741µs)
    2022/09/21 06:53:23 [PjyQyQFStFubVVdHtAkn] [info] GET /api.ch.gov.uk-specifications/swagger-2.0/models/insolvency.json (200, 49.772µs)
    2022/09/21 06:53:23 Importing OpenAPI specifications from http://127.0.0.1:31717/api.ch.gov.uk-specifications/swagger-2.0/spec/testDataGenerator.json
    2022/09/21 06:53:23 [jEQxCqkDIfTGXeJtuncb] [info] GET /api.ch.gov.uk-specifications/swagger-2.0/spec/testDataGenerator.json (200, 61.637µs)
    2022/09/21 06:53:23 [fqQUsXTOdPORvAUkAwww] [info] GET /api.ch.gov.uk-specifications/swagger-2.0/spec/testDataGenerator.json (200, 54.567µs)
    2022/09/21 06:53:23 Registering reference documentation
    2022/09/21 06:53:23 Registering guides
    2022/09/21 06:53:23 listening on 0.0.0.0:31717 for unsecured connections

It's worth noticing that company-accounts.json, for example, is actually not listed in the above stderr.

The specs which are intended for the private web site are listed [here](https://github.com/companieshouse/dapperdox.developer.ch.gov.uk/blob/9571799/spec_args.sh#L24-L35) (directly or indirectly).


In particular, company-accounts.json comes (indirectly) sourced [here](https://github.com/companieshouse/dapperdox.developer.ch.gov.uk/blob/9571799/spec_args.sh#L28) via filings.json

## Docker
To run this service locally in Docker, simply enable the `dapperdox-developer-ch-gov-uk` service.
The specs can then be accessed at [http://developer-specs.chs.local](http://developer-specs.chs.local)

