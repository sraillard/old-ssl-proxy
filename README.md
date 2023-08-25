SSL proxy for servers only supporting older SSL/TLS protocols
=============================================================

This project was inspired by: https://bitbucket.org/ValdikSS/oldssl-proxy/

Quick notes
-----------

- The goal is to allow a modern browser to negociate a SSL connection with an older server
- This proxy will act as a man in the middle for all SSL/TLS connections, **there is NOT MUCH security using this proxy!**
- There will be no server certificate check (self-signed certificates are accepted)
- Each connection will generate an error as the certificate used with the client is self-signed
- Older protocols are supported (SSLv3, TLS v1.0)
- All the logging is done in stdout, the SSL protocol/ciphers negociated on the client side and server side are displayed

Using the proxy
---------------

Before using the proxy, you'll need to change the proxy parameters of your browser. The default proxy port is TCP/3128.

To run the proxy:  
`docker run --rm -it -p 3128:3128 sraillard/old-ssl-proxy:v1`

Image build
-----------

`docker build -t sraillard/old-ssl-proxy:v1 .`
