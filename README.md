Duplicity cron on Docker
=============

This image runs [duplicity](http://duplicity.nongnu.org/) as a Cron-Job on Ubuntu 15.10.

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
github.com/dsgrafiniert (dominik at familie-schoen.com)

it is based on [ThomasSteinbach/docker-duplicity](https://github.com/ThomasSteinbach/docker-duplicity)
github.com/ThomasSteinbach (thomass at aikq.de)
