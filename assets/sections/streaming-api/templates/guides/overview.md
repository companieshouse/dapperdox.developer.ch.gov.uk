Navigation: Getting started
SortOrder: 100

# Getting started with the streaming API

The Companies House streaming API gives you access to realtime data changes of
the information held at Companies House. This delivers the same information
that is available through the on-demand [REST API](https://developer.company-information.service.gov.uk) `GET`
requests, but instead pushes data to your client as it changes, through a
long-running connection that you first establish.

## How it works

The streaming endpoints return exactly the same data resources as the
equivalent on-demand [data API](https://developer.company-information.service.gov.uk), wrapped in a small JSON
envelope that provides additional metadata, such as what type of resource is
being sent, and the date-time it was published.

The stream envelope contains the following information:
```
{
    "event": {
        "fields_changed": [
            "string"
        ],
        "published_at": "date-time",
        "timepoint": "integer",
        "type": "string"
    },
    "resource_id": "string",
    "resource_kind": "string",
    "resource_uri": "string",
    "data": { }
}
```

This structure is standard across all the stream API endpoints. It is the
`data` sub-document that contains the data resource being streamed.


## Data snapshots

As the stream delivers realtime information, you cannot use it to obtain a
complete copy of the data held at Companies House. You can, however, use it to
keep a dataset current.

For this purpose, Companies House produces snapshot datasets that you can
import into a database, and subsequenlty keep current with the streaming API.

The snapshots contain the stream `timepoint` at which they were taken. By
connecting to the streaming endpoint with this `timepoint`, you will pick up
the stream where the snapshot left off. See [Timepoints](/streaming-api/guides/overview#timepoints)
for further information.

## Connecting to a streaming endpoint

Establishing a connection to the streaming APIs involves making a long-running
HTTP request, and incrementally processing each response line. Conceptually, you can
think of this as downloading an infinitely long file over HTTP.

### Authentication

Access to Companies House streaming API services requires authentication. The
[Authentication](/streaming-api/guides/authentication) page describes the
authentication mechanism used by the streaming API, how to register your
application and obtain an API key.

### Connecting

Create an HTTP connection using a recent HTTP client library, and consume
the streaming data for as long as possible. Repeatedly connecting and
disconnecting is a resource expensive operation, and you may be rate-limited
if you frequently reconnect.

Our servers will maintain the connection indefinitely, only dropping it
in the event of high network congestion, routine maintenance, server errors
or too many connections from an application.

Be aware of buffering proxies between your client and our servers, and of
HTTP client libraries that internally buffer and only return the response
data when the connection is closed. The streaming API will not work
if buffering is occuring within the connection route. Most recent HTTP
clients will return data incrementally.

#### Connection limits

A maximum of two concurrent connections per-account can be made to the streaming API.
Each additional connection attempt above this limit will cause the oldest open connection
to close.

Be aware that repeatedly opening connections to the streaming API will result
in the client being rate limited.


### Disconnecting

The streaming API connection will be disconneced under the following circumstances:

- A client establishes too many connections with the same credentials. When
  this occurs, the oldest connection will be terminated. This means you have
  to be careful not to run too many reconnecting clients in parallel with the
  same credentials, or else they will take turns disconnecting each other.

- A client reads data too slowly. Every streaming connection is backed by a
  queue of messages to be sent to the client. If this queue grows too large
  over time, the connection will be closed.

- Our streaming servers are restarted. This happens infrequently, and is
  usually due to code deployment or a rebalancing of our server workload.

- Our network configuration changes. This is rare, and occurs when a network
  reconfiguration takes place or a load balancer restarts.

### Keeping a connection alive

HTTP connections will typically be timed out and disconnected by clients
if there is no data transfer for a while. To avoid this and keep a connection
alive when there is no new data to stream, the streaming API periodically sends
an empty record as a heartbeat. These take the form of a blank line within the
streamed feed, and must be ignored by client applications.

### Reconnecting

Repeatedly reconnecting to the streaming API is a resource expensive operation,
and you may be rate-limited if you do this frequently.

If you are disconnected, try and reconnect and if that fails, implement a
back off strategy based on the failure reason:

- If you receive an HTTP status code `429`, then you are being subjected to
  rate-limiting and you must wait **one minute** before attempting a
  reconnect. If you do not do this, you will receive a further `429` responses
  and the rate-limit period will increase.

- Reconnects failing with a retryable HTTP error should be retried after 10 seconds.

- If you receive a network error, implement a back off for a few seconds to allow
  the network error to pass, as they are frequently transient.


## Timepoints

The streaming API endpoints are each backed by a queue, so that clients can
disconnect periodically and reconnect some time later. This queue backlog
contains as many events as needed to bring the most recently produced data
snapshot up to date.

By default a stream will deliver data events as they happen after a connection 
is established. Clients can request that the stream starts to deliver data
events from a point further back in the queue by specifying a timepoint on
connection. 

Every event received from the stream is accompanied by a corresponding
timepoint. When clients reconnect to the stream, they should supply the timepoint
of the last sucessfully processed event to ensure continuity of data. If
the timepoint is too far in the past, clients will receive a `416` error.
Clients will also receive this error if they consume events too slowly.

A data snapshot also comes with a timepoint, which gives you the point at which
the snapshot was taken.

## Rate limiting

If clients do not implement a connection back-off strategy, repeat connection
attempts may result in the client being rate limited for a short period, during
which the client will receive a `429` HTTP status code.

Clients *must* detect a `429` HTTP status code and implement a back-off strategy.
If they do not, the client IP address will be blocked by Companies House.
