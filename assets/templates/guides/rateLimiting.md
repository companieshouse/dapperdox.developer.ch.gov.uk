Title: Rate limiting
Navigation: Rate limiting
SortOrder: 70

Rate limiting
=============

Rate limiting is applied to the Companies House API to ensure a
high-quality service is delivered for all users, and to protect client
applications from unexpected loops.

Per application rates
---------------------

You can make up to 600 requests within a five-minute period. If you
exceed this limit, you will receive a `429 Too Many Requests` HTTP
status code for each request made within the remainder of the
five-minute window. At the end of the period, your rate limit will reset
back to its maximum value of 600 requests.

We reserve the right to ban without notice applications that regularly 
exceed or attempt to bypass the rate limits.

Increasing your rate limit
--------------------------

If you have an application that requires a higher rate limit than the
default applied, then please contact us, we will be happy to help.

