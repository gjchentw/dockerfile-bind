FROM gjchen/alpine:3.7

ENV	CERTDIR=/etc/ssl/certs.d \
	ZONES="mytld a.mytld" \
	DNS_SERVERS="192.168.1.1; 192.168.2.1;"

RUN	apk --no-cache --no-progress upgrade -f && \
	apk add --no-cache --no-progress bind bind-tools git perl && \
	git clone https://github.com/lukas2511/dehydrated.git /opt/dehydrated && \
	ln -s /opt/dehydrated/dehydrated /etc/ssl/dehydrated && \
	git clone https://github.com/fanf2/nsdiff.git /opt/nsdiff && \
	mkdir -p /etc/bind/named.conf.d /etc/ssl/certs.d

ADD	s6.d /etc/s6.d

#wget -O - https://letsencrypt.org/certs/isrgrootx1.pem https://letsencrypt.org/certs/lets-encrypt-x1-cross-signed.pem https://letsencrypt.org/certs/letsencryptauthorityx1.pem https://www.identrust.com/certificates/trustid/root-download-x3.html | tee -a letsencrypt-ca-certs.pem && \
ADD	letsencrypt-ca-certs.pem /etc/ssl/

EXPOSE	53/tcp 53/udp
