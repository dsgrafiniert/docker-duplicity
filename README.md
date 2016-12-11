Docker Unison
=============

This image runs plain [duplicity](http://duplicity.nongnu.org/) as entrypoint on Ubuntu 15.10.

Use with Amazon Drive
---------------------

First generate an oauth Token:

```
docker run -it --rm --entrypoint bash thomass/duplicity setup_amazon_oauth
```

Write the `{"access_token":...}` part into a file and mount this file as
volume on further executions:

```
docker run --rm -v /path/to/token:/root/.duplicity_ad_oauthtoken.json ... thomass/duplicity ....
```

Licence
-------

The whole repository is licenced under BSD. Please mention following:

github.com/ThomasSteinbach (thomass at aikq.de)
