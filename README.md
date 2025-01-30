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

    2025/01/30 14:56:04 Registering specifications
    2025/01/30 14:56:05 Importing OpenAPI specifications from http://127.0.0.1:4004/api.ch.gov.uk-specifications/swagger-2.0/spec/streaming.json
    2025/01/30 14:56:05 [nKuOwidBqydmwIdqvCQl] [info] GET /api.ch.gov.uk-specifications/swagger-2.0/spec/streaming.json (200, 94.042µs)
    2025/01/30 14:56:05 [lqmvGMaAippNTCkGvEfd] [info] GET /api.ch.gov.uk-specifications/swagger-2.0/spec/stream.json (200, 37.583µs)
    2025/01/30 14:56:05 [uWXRKBoEKtKgFbARCLNL] [info] GET /api.ch.gov.uk-specifications/swagger-2.0/models/stream/officerAppointments.json (200, 14.333µs)
    2025/01/30 14:56:05 [SIzqHlkNLeXqDsgLsKId] [info] GET /api.ch.gov.uk-specifications/swagger-2.0/models/stream/streamEnvelope.json (200, 13.25µs)
    2025/01/30 14:56:05 [EkLZaibryilOujOJWsNz] [info] GET /api.ch.gov.uk-specifications/swagger-2.0/spec/companyOfficerList.json (200, 33.417µs)
    2025/01/30 14:56:05 [gfRhGEnZSSeNnYLOWQUE] [info] GET /api.ch.gov.uk-specifications/swagger-2.0/models/stream/companyExemptions.json (200, 10.167µs)
    2025/01/30 14:56:05 [bPbuImneUnNXUCRTimCN] [info] GET /api.ch.gov.uk-specifications/swagger-2.0/spec/exemptions.json (200, 25.084µs)
    2025/01/30 14:56:05 [hSYdFjmqttkvatykUGAr] [info] GET /api.ch.gov.uk-specifications/swagger-2.0/models/stream/psc.json (200, 6.833µs)
    2025/01/30 14:56:05 [DBVCukTmoZHuKBlUndNo] [info] GET /api.ch.gov.uk-specifications/swagger-2.0/spec/pscModels.json (200, 32.291µs)
    2025/01/30 14:56:05 [pTcwCFPdVohhPInCLLJf] [info] GET /api.ch.gov.uk-specifications/swagger-2.0/models/stream/disqualifiedOfficers.json (200, 9.042µs)
    2025/01/30 14:56:05 [aGkmuroINfIwtMAOFakc] [info] GET /api.ch.gov.uk-specifications/swagger-2.0/spec/disqualifiedOfficersStream.json (200, 13.084µs)
    2025/01/30 14:56:05 [WYUrMrRnIbDFWECwJVYi] [info] GET /api.ch.gov.uk-specifications/swagger-2.0/spec/disqualifications.json (200, 41.542µs)
    2025/01/30 14:56:05 [cMBcjfHfyxuMrClxujnq] [info] GET /api.ch.gov.uk-specifications/swagger-2.0/models/stream/filingHistory.json (200, 9.208µs)
    2025/01/30 14:56:05 [tflpBWJLRkqXhAhMqKqq] [info] GET /api.ch.gov.uk-specifications/swagger-2.0/spec/filingHistory.json (200, 24.458µs)
    2025/01/30 14:56:05 [VtvjomvokACkvvSZunTO] [info] GET /api.ch.gov.uk-specifications/swagger-2.0/models/stream/insolvencyCases.json (200, 9.709µs)
    2025/01/30 14:56:05 [CcPkUEQTxTCPeQItTvku] [info] GET /api.ch.gov.uk-specifications/swagger-2.0/spec/insolvency.json (200, 36.667µs)
    2025/01/30 14:56:05 [HKbVWjptVGiEHGQTzUHo] [info] GET /api.ch.gov.uk-specifications/swagger-2.0/models/stream/companyProfile.json (200, 7.5µs)
    2025/01/30 14:56:05 [aZQHfvgvgolAxzXBISvd] [info] GET /api.ch.gov.uk-specifications/swagger-2.0/spec/companyProfile.json (200, 27.084µs)
    2025/01/30 14:56:05 [oiNQcdyjRERTDKlNiYTq] [info] GET /api.ch.gov.uk-specifications/swagger-2.0/models/stream/charges.json (200, 9.75µs)
    2025/01/30 14:56:05 [vIUiclngmbtHCYZkGRNE] [info] GET /api.ch.gov.uk-specifications/swagger-2.0/spec/charges.json (200, 22.5µs)
    2025/01/30 14:56:05 [CszdOAhtZwCYrwhJCOPM] [info] GET /api.ch.gov.uk-specifications/swagger-2.0/models/stream/pscStatements.json (200, 9.125µs)
    2025/01/30 14:56:05 Importing OpenAPI specifications from http://127.0.0.1:4004/api.ch.gov.uk-specifications/swagger-2.0/spec/swagger.json
    2025/01/30 14:56:05 [mlKzdmfVMfEjCOhVgIgp] [info] GET /api.ch.gov.uk-specifications/swagger-2.0/spec/swagger.json (200, 24.458µs)
    2025/01/30 14:56:05 [UZgbxZzJqITVVvXgpFpQ] [info] GET /api.ch.gov.uk-specifications/swagger-2.0/spec/disqualifications.json (200, 28.625µs)
    2025/01/30 14:56:05 [clnhQJeommwtXkwOuhZi] [info] GET /api.ch.gov.uk-specifications/swagger-2.0/spec/charges.json (200, 24.416µs)
    2025/01/30 14:56:05 [pVtDMbsvLmqTeYBJRnRh] [info] GET /api.ch.gov.uk-specifications/swagger-2.0/spec/companyUKEstablishments.json (200, 19.875µs)
    2025/01/30 14:56:05 [wtYlkzPomNmTpgYRuNiu] [info] GET /api.ch.gov.uk-specifications/swagger-2.0/spec/psc.json (200, 31.125µs)
    2025/01/30 14:56:05 [hzEUefboGNMPBsXWACyc] [info] GET /api.ch.gov.uk-specifications/swagger-2.0/spec/pscModels.json (200, 33.458µs)
    2025/01/30 14:56:05 [OLSdPYMtcmJsClDaesoB] [info] GET /api.ch.gov.uk-specifications/swagger-2.0/spec/search-companies.json (200, 27.667µs)
    2025/01/30 14:56:05 [cBqanONOVhHCUSsTrhhy] [info] GET /api.ch.gov.uk-specifications/swagger-2.0/spec/companyAddress.json (200, 27.542µs)
    2025/01/30 14:56:05 [XyevOwifstDJIgsyFBMX] [info] GET /api.ch.gov.uk-specifications/swagger-2.0/models/registeredOfficeAddress.json (200, 18.834µs)
    2025/01/30 14:56:05 [eBPtvIcmhNbOEPqNWwUp] [info] GET /api.ch.gov.uk-specifications/swagger-2.0/models/genericModels.json (200, 5.584µs)
    2025/01/30 14:56:05 [HJUzJmxMxMcEifLgsawu] [info] GET /api.ch.gov.uk-specifications/swagger-2.0/spec/filingHistory.json (200, 22.542µs)
    2025/01/30 14:56:05 [gWHqcOTmkGYXFPjvctmN] [info] GET /api.ch.gov.uk-specifications/swagger-2.0/spec/errorModel.json (200, 8.292µs)
    2025/01/30 14:56:05 [PNWbwymPMHQwUPHJHThf] [info] GET /api.ch.gov.uk-specifications/swagger-2.0/spec/search.json (200, 25.792µs)
    2025/01/30 14:56:05 [YTtiuXqdSFcvwOqqTaTc] [info] GET /api.ch.gov.uk-specifications/swagger-2.0/spec/insolvency.json (200, 33.792µs)
    2025/01/30 14:56:05 [tVeYBnDUtMWVkXsHkSXU] [info] GET /api.ch.gov.uk-specifications/swagger-2.0/spec/exemptions.json (200, 23.708µs)
    2025/01/30 14:56:05 [vOaESfPhdRkkJUScWOLc] [info] GET /api.ch.gov.uk-specifications/swagger-2.0/spec/companyOfficerList.json (200, 24.542µs)
    2025/01/30 14:56:05 [dvKCnmqdpbaCbEFLYAow] [info] GET /api.ch.gov.uk-specifications/swagger-2.0/spec/companyRegisters.json (200, 23.375µs)
    2025/01/30 14:56:05 [MtarLxsplwqAnlXDUIXu] [info] GET /api.ch.gov.uk-specifications/swagger-2.0/spec/companyProfile.json (200, 40.166µs)
    2025/01/30 14:56:05 [lFMvJLsJVrQUbOYgBjlM] [info] GET /api.ch.gov.uk-specifications/swagger-2.0/spec/officerAppointmentList.json (200, 42.084µs)
    2025/01/30 14:56:05 Importing OpenAPI specifications from http://127.0.0.1:4004/document.api.ch.gov.uk-specifications/swagger-2.0/spec/swagger.json
    2025/01/30 14:56:05 [oeNevvCdkOydzbfipgFd] [info] GET /document.api.ch.gov.uk-specifications/swagger-2.0/spec/swagger.json (200, 34.709µs)
    2025/01/30 14:56:05 Importing OpenAPI specifications from http://127.0.0.1:4004/account.ch.gov.uk-specifications/swagger-2.0/identity-public.json
    2025/01/30 14:56:05 [ELjYsylgSJDaStEKUFQt] [info] GET /account.ch.gov.uk-specifications/swagger-2.0/identity-public.json (200, 26.417µs)
    2025/01/30 14:56:05 Importing OpenAPI specifications from http://127.0.0.1:4004/api.ch.gov.uk-specifications/swagger-2.0/spec/filings-public.json
    2025/01/30 14:56:05 [RMbPzdBZxeWoTyIcecLA] [info] GET /api.ch.gov.uk-specifications/swagger-2.0/spec/filings-public.json (200, 23.334µs)
    2025/01/30 14:56:05 [ZbXdqgqakbRPZGzGYkMs] [info] GET /api.ch.gov.uk-specifications/swagger-2.0/spec/insolvency.json (200, 52.208µs)
    2025/01/30 14:56:05 [aYvriJbRRaHhTUwSTNcH] [info] GET /api.ch.gov.uk-specifications/swagger-2.0/models/insolvency.json (200, 33.833µs)
    2025/01/30 14:56:05 [EHudbvShbKzbOxwgOPvo] [info] GET /api.ch.gov.uk-specifications/swagger-2.0/models/genericModels.json (200, 7.75µs)
    2025/01/30 14:56:05 [VrMhtrGtapyqzlaPcEtH] [info] GET /api.ch.gov.uk-specifications/swagger-2.0/models/errors.json (200, 13.584µs)
    2025/01/30 14:56:05 [vbLtGxqtsXCaOlrDWGhy] [info] GET /api.ch.gov.uk-specifications/swagger-2.0/spec/transactions.json (200, 29.084µs)
    2025/01/30 14:56:05 [gQeHZuHYRuiYgbxncDFH] [info] GET /api.ch.gov.uk-specifications/swagger-2.0/models/transactions.json (200, 28.667µs)
    2025/01/30 14:56:05 [ecVJWYxAYEEuZQIAqYxs] [info] GET /api.ch.gov.uk-specifications/swagger-2.0/spec/companyAddress.json (200, 23.542µs)
    2025/01/30 14:56:05 [fyxPJgCAZOSWiFcIiQis] [info] GET /api.ch.gov.uk-specifications/swagger-2.0/spec/registeredEmailAddress.json (200, 38.208µs)
    2025/01/30 14:56:05 [kcnqeRduGnevpcPwSALV] [info] GET /api.ch.gov.uk-specifications/swagger-2.0/models/registeredOfficeAddress.json (200, 16.375µs)
    2025/01/30 14:56:05 [nXrqcVWFqiaVosKmWpfv] [info] GET /api.ch.gov.uk-specifications/swagger-2.0/models/registeredEmailAddress.json (200, 16.125µs)
    2025/01/30 14:56:05 Importing OpenAPI specifications from http://127.0.0.1:4004/api.ch.gov.uk-specifications/swagger-2.0/spec/test-data-generator-public.json
    2025/01/30 14:56:05 [VrSQXUexHwBIKpQtYnYH] [info] GET /api.ch.gov.uk-specifications/swagger-2.0/spec/test-data-generator-public.json (200, 33.959µs)
    2025/01/30 14:56:05 [NsvqvYpPFOAmfqdsdQnm] [info] GET /api.ch.gov.uk-specifications/swagger-2.0/spec/test-data-generator-public.json (200, 41.333µs)
    2025/01/30 14:56:05 Importing OpenAPI specifications from http://127.0.0.1:4004/api.ch.gov.uk-specifications/swagger-2.0/spec/pscDiscrepancies.json
    2025/01/30 14:56:05 [irfyxNWUqlPPTeZADWRF] [info] GET /api.ch.gov.uk-specifications/swagger-2.0/spec/pscDiscrepancies.json (200, 35.167µs)
    2025/01/30 14:56:05 Registering reference documentation
    2025/01/30 14:56:05 Registering guides
    2025/01/30 14:56:05 listening on 0.0.0.0:4004 for unsecured connections

It's worth noticing that company-accounts.json, for example, is actually not listed in the above stderr.

The specs which are intended for the private web site are listed [here](https://github.com/companieshouse/dapperdox.developer.ch.gov.uk/blob/9571799/spec_args.sh#L24-L35) (directly or indirectly).


In particular, company-accounts.json comes (indirectly) sourced [here](https://github.com/companieshouse/dapperdox.developer.ch.gov.uk/blob/9571799/spec_args.sh#L28) via filings.json

## Docker
To run this service locally in Docker, simply enable the `dapperdox-developer-ch-gov-uk` service.
The specs can then be accessed at [http://developer-specs.chs.local](http://developer-specs.chs.local)



