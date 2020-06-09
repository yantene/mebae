FROM yantene/takt:ver-0.310
LABEL maintainer="yantene <contact@yantene.net>"

WORKDIR /mnt

RUN \
  apt update && \
  apt install -y fluidsynth fluid-soundfont-gm sudo make flac opus-tools lame && \
  apt clean && \
  rm -rf /var/lib/apt/lists/*

RUN { \
    echo '#!/bin/bash'; \
    echo 'test -v LUID && useradd -u ${LUID} -o -m user'; \
    echo 'test -v LGID && groupmod -g ${LGID} user'; \
    echo 'sudo -u#${LUID:-0} -g#${LGID:-0} /usr/bin/make "$@" SOUND_FONT=/usr/share/sounds/sf2/FluidR3_GM.sf2'; \
  } > /entrypoint.sh && \
  echo 'Set disable_coredump false' >> /etc/sudo.conf && \
  chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
