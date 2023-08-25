FROM alpine:3.15.10

# Openssl compilation with weak ciphers/ssl3
RUN cd /root && \
  apk add alpine-sdk && \
  git clone https://github.com/alpinelinux/aports.git --depth 1 && \
  abuild-keygen -an && \
  cd aports/main/openssl && \
  sed -i 's/no-ssl3/enable-ssl3 enable-ssl3-method/' APKBUILD && \
  sed -i 's/no-weak-ssl-ciphers/enable-weak-ssl-ciphers/' APKBUILD && \
  abuild -F -r && \
  cd /root/packages/main/x86_64/ && \
  apk add --allow-untrusted libcrypto*.apk libssl*.apk openssl-3.*.apk && \
  apk del alpine-sdk && \
  rm -rf /var/cache/apk/*

# Squid installation
RUN apk add squid && \
  /usr/lib/squid/security_file_certgen -c -s /var/cache/squid/ssl_db -M 4MB && \
  chown squid:squid -R /var/cache/squid/ssl_db && \
  mkdir /etc/squid/ssl_cert && \
  cd /etc/squid/ssl_cert && \
  openssl req -new -newkey rsa:1024 -sha1 -days 3650 -nodes -x509 -extensions v3_ca -subj '/C=AU/ST=Some-State/O=OldSSL Proxy' -keyout myCA.pem -out myCA.pem -batch && \
  chown squid:squid -R /etc/squid/ssl_cert/

# Copy the configuration file
COPY squid.conf /etc/squid/squid.conf

# Copy the entrypoint script
COPY entrypoint.sh /root/entrypoint.sh

# Default squid proxy port
EXPOSE 3128/tcp

# Launch entrypoint script
ENTRYPOINT /root/entrypoint.sh

