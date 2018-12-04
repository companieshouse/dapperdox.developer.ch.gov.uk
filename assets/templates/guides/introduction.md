Navigation: Introduction

# Introduction to the Companies House JSON API

The Companies House API is a REST API that provides a simple, consistent approach to requesting and modifying data. REST stands for Representational State Transfer, an architectural software style in which standard HTTP request methods are used to retrieve and modify representations of data. This is identical to the process of retrieving a web page, or submitting a web form.

Previous versions of the Companies House API implemented an XML-RPC style of interface. Here data is retrieved or submitted by POSTing XML documents to the service, each defining the method to be called and the data to be processed.

The difference between both API approaches is defined below.

XML-RPC / SOAP

An XML-RPC or or SOAP API might provide four methods to manipulate a customer record:

http://api.example.domain/createCustomer
http://api.example.domain/deleteCustomer
http://api.example.domain/updateCustomer
http://api.example.domain/getCustomer

Thus, each method defines an action that can be carried out on an entity of a particular type, in this case a customer. As an XML-RPC API, each method accepts or returns an XML document representing the customer.

The HTTP request that would be sent by the client when calling the getCustomer method is (note that such requests must be made through a HTTP POST, as a GET cannot contain a message body):

```
POST http://api.example.domain/getCustomer HTTP/1.1
Content-Type: text/xml

<Request>
  <CustomerNumber>12345</CustomerNumber>
</Request>
```

The XML document submitted to the method provides the customerNumber of the customer record being requested.

A common alternative calling mechanism is to provide the method name inside the XML request document. In this case, request documents are sent to a single URL, as is the case with the previous Companies House XML API:

```
POST http://api.example.domain/Gateway HTTP/1.1
Content-Type: text/xml

<Request>
    <Method>getCustomer</Method>
    <Data>
        <CustomerNumber>12345</CustomerNumber>
    </Data>
</Request>
```

There are several problem with such APIs. First, even though HTTP is frequently used as the transport protocol for such APIs, they cannot take advantage of existing internet infrastructure, such as HTTP caches, gateway routing or proxies. This is primarily due to the lack of GET request use, and/or having a single URL for multiple methods on a resource. Second, such APIs require designers to define new, application specific operations (methods) for each resource.

# Representational State Transfer

REST differs from previous approaches to API design, such as XML-RPC and SOAP which expose object methods, by directly exposing data resources. Each resource is explicitly addressed through its own URI, and can be accessed using nothing more than a standard HTTP request.

HTTP verbs such as POST, GET,  PUT and DELETE are used to retrieve and modify resources at these URIs, and operate by passing resource representations between the client and the server.

In contrast to the above XML-RPC examples, the equivalent RESTful API request for a customer record would be:

GET http://api.example.domain/customer/12345 HTTP/1.1
Note that the resource request is made using the GET method, and that there is no request body.

In a RESTful API, a resource is modified by POSTing a revised resource representation, in this case JSON, to the same resource URL:

```
POST http://api.example.domain/customer/12345 HTTP/1.1
Content-Type: text/json

{
    "CustomerName": "Joe Bloggs",
    "Address"     : "",
    "etc"         : "etc"
}
```

Similarly, a resource may be deleted by sending a DELETE request to the resource URL:

```
DELETE http://api.example.domain/customer/12345 HTTP/1.1
```

Thus REST uses the existing features of the HTTP protocol, and does not permit the designer to define application specific operations. In addition, because each resource has a globally unique URI and is able to make use of the GET method for resource requests, such APIs benefit from existing network components such as caches, proxies and intelligent routing.

The Companies House RESTful API page provides an overview of the Companies House API.
