FROM mailcow/dovecot:1.126
LABEL maintainer "Jacob Baungard Hansen <jacob@baungard-hansen.me>"

RUN apt-get update && apt-get install -y libmail-gnupg-perl git
RUN git clone https://gitlab.com/mikecardwell/gpgit.git /opt/gpgit/

COPY encryption.sieve /usr/lib/dovecot/sieve/encryption.sieve
RUN mkdir -p /opt/sieve-filters
RUN ln -s /opt/gpgit/gpgit.pl /opt/sieve-filters/gpgit
