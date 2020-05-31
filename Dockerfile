FROM ubuntu:20.04
LABEL maintainer="yantene <contact@yantene.net>"

ENV DEBIAN_FRONTEND noninteractive

WORKDIR /mnt

RUN \
  apt update && \
  apt install -y curl make gcc g++ file flex libasound2-dev libreadline6-dev

RUN \
  tmpdir=`mktemp -d` && \
  cd ${tmpdir} && \
  curl -L -O 'https://excellmedia.dl.sourceforge.net/project/takt/takt-0.310-src.tar.gz' && \
  tar xf takt-0.310-src.tar.gz && \
  cd takt-0.310 && \
  ./configure && \
  make && \
  make install && \
  rm -rf ${tmpdir}

RUN apt install -y fluidsynth fluid-soundfont-gm sudo

RUN \
  apt autoremove -y curl gcc g++ file flex && \
  apt clean && \
  rm -rf /var/lib/apt/lists/*

RUN { \
    echo '#!/bin/bash'; \
    echo 'if test ! -v LOCAL_UID -o ! -v LOCAL_GID; then'; \
    echo '  echo "Please specify \$LOCAL_UID and \$LOCAL_GID!" 2>&1'; \
    echo '  exit -1'; \
    echo 'fi'; \
    echo 'useradd -u ${LOCAL_UID} -o -m user'; \
    echo 'groupmod -g ${LOCAL_GID} user'; \
    echo 'export HOME=/home/user'; \
    echo 'exec sudo -u user /usr/bin/make SOUND_FONT=/usr/share/sounds/sf2/FluidR3_GM.sf2'; \
  } > /root/entrypoint.sh && \
  echo 'Set disable_coredump false' >> /etc/sudo.conf && \
  chmod +x /root/entrypoint.sh

ENTRYPOINT ["/root/entrypoint.sh"]
