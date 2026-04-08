# pygeoip

This library is used by `pypkjs` to get the user's location
based on their IP address.

Since this library has been deprecated for at least 8 years
and its only usage seems to be
[this line](https://github.com/coredevices/pypkjs/blob/master/pypkjs/javascript/navigator/geolocation.py#L39),
I think it could be easily replaced
by an actively maintained library
such as [GeoIP2](https://github.com/maxmind/GeoIP2-python).
