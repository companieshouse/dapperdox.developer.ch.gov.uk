Title: Getting started
Navigation: Getting started
SortOrder: 20

Getting started with the Companies House API
============================================

The Companies House API lets you retrieve information about limited
companies (and other companies that fall within the Companies Act 2006).
The data returned is live and real-time, and is simple to use and
understand.

Quick start
-----------

If you are already familiar with JSON RESTful APIs, then you can jump
straight in with the [quick start
guide](/guides/quickStart).

Otherwise, read on for a quick tour of the essentials.

First steps
-----------

- [Getting started with the Companies House API](#getting-started-with-the-companies-house-api)
  - [Quick start](#quick-start)
  - [First steps](#first-steps)
    - [Set up a Companies House account](#set-up-a-companies-house-account)
    - [Overview](#overview)
    - [REST web services](#rest-web-services)
    - [The JSON data format](#the-json-data-format)
    - [Authentication](#authentication)
    - [Explore the API](#explore-the-api)
    - [Developer guidelines](#developer-guidelines)
    - [API rate limits](#api-rate-limits)
    - [Enumerated types](#enumerated-types)

### Set up a Companies House account

To be able to explore and perform tests with the Companies House API,
you need to register a [user account](/developer/signin) with Companies
House.

### Overview

The Companies House API
[overview](/guides/companiesHouseAPI)
describes the basic operation of the API.

### REST web services

REST, or [Representational State
Transfer](http://en.wikipedia.org/wiki/Representational_state_transfer),
is an architectural software style in which standard HTTP requests are
used to provide a simple and consistent approach to requesting and
modifying data.

In a RESTful style of API, data resources are allocated unique URLs and
manipulated through standard HTTP verbs such as `GET` to request a
resource, `POST` to create a resource, `PUT` to change a resource, and
`DELETE` to remove a resource.

Further details on how the Companies House REST API works can be found
in the
[introduction](/guides/introduction)
page.

### The JSON data format

JSON, or [JavaScript Object
Notation](https://en.wikipedia.org/wiki/JSON), is an open, standard
format for storing and exchanging data. It is easier to use than XML, is
more compact, and can be used as a data format by any programming
language. This makes it ideal for HTTP-based API services.

Further information can be found at [json.org](http://www.json.org).

### Authentication

Access to all API services requires authentication. The
[Authorisation](/guides/authorisation)
page describes the authorisation mechanism used by the Companies House
API, and how to register your application.

### Explore the API

Each Companies House API reference page contains an embedded "explorer"
that allows the reader to try out the service *in-situ*, without having
to write any client code at all.

### Developer guidelines

There are some simple developer
[guidelines](/guides/developerGuidelines)
you can follow to help you achieve success with the Companies House API.

### API rate limits

The Companies House API is subject to [rate
limiting](/guides/rateLimiting) to protect
the quality of service for all users.

### Enumerated types

A majority of the resources returned by the Companies House API contain
members that reference [enumuration
types](https://en.wikipedia.org/wiki/Enumerated_type). This helps make
the resources self-documenting, and allow clients to interpret the
meaning of a resource member without needing to otherwise parse a text
description. Enumeration types are frequently used to supplement or
replace a text description, which allows clients to display their own
version of a description, more fitting their use case, or provide
descriptions in multiple languages.

The collection of enumuration types used by Companies House are
available on
[GitHub](https://github.com/companieshouse/api-enumerations). These
files provide a mapping between enumuration type and text description,
and are divided into sets or classes. Each API resource member will
define which class of enumuration is being returned.

A planned enhancement to the enumuration scheme is the provision of API
endpoints that will return the enumuration class catalogue. This avoids
having enumurations hard-coded within a client, and by periodically
checking for change through ETags, avoids clients having to download the
full catalogue unnecessarily.

