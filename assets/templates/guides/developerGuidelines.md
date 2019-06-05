Title: Developer guidelines
Navigation: Developer guidelines
SortOrder: 60

Developer guidelines
====================

To help achieve the successful development of your application, when
using the Companies House API you should adhere to a few simple
guidelines:

- [Developer guidelines](#developer-guidelines)
  - [Data resources](#data-resources)
  - [Security](#security)
  - [Securing API keys](#securing-api-keys)

Data resources
--------------

Data is mostly returned as JSON documents. Your application must
tolerate the order of document members changing over time, and expect to
receive members it hasn't seen before.

Security
--------

The API can only be accessed over TLS. We recommend using TLS 1.2.

Securing API keys
-----------------

It is important to keep your API keys secure, to prevent them being
discovered, your account being compromised and your rate-limit quota
being exceeded. There are a few best practices that can help with this:

1.  ### Do not embed API keys in your code

    Storing keys in your application code increases the risk that they
    will be discovered, particularly if any of your source code is made
    public, or can be viewed by people who should not have access to the
    key. Instead, you should consider storing them inside environment
    variables or configuration.

2.  ### Do not store API keys in your source tree

    If you store API keys in files, perhaps inside a configuration or
    environment file, these should not be stored inside the application
    source tree, just in case part or all of the source is made public
    or can be viewed by people who should not have access to the key.

3.  ### Restrict API key use by IP address and domain

    Limiting the use of a key to a specific IP address or domain will
    reduce the usefulness of a key that becomes compromised.

4.  ### Regenerate your API keys

    By regenerating your API keys regularly, and certainly with each
    application release, you can lessen the chance that a key will be
    discovered.

5.  ### Delete API keys when no longer required

    Removing obsolete keys from your Developer Hub
    registered-applications page limits the number of entry points into
    your account.

