FROM ghcr.io/mailcow/dovecot:2.33

# RUN apt-get update && apt-get install -y libmail-gnupg-perl git
RUN apk add git perl gnupg make curl
RUN curl -fsSL https://raw.githubusercontent.com/skaji/cpm/main/cpm | perl - install -g App::cpm
RUN cpm install --global Mail::GnuPG
RUN git clone https://gitlab.com/mikecardwell/gpgit.git /opt/gpgit/

COPY encryption.sieve /usr/lib/dovecot/sieve/encryption.sieve
RUN mkdir -p /opt/sieve-filters
RUN ln -s /opt/gpgit/gpgit.pl /opt/sieve-filters/gpgit
