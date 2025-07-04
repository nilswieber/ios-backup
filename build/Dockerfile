
FROM debian:11-slim

RUN mkdir -p /app/src

RUN apt-get update && apt-get upgrade -y
RUN apt-get install -y build-essential pkg-config checkinstall git autoconf automake
RUN apt-get install -y libtool-bin libssl-dev libcurl4-openssl-dev
RUN apt-get install -y libusb-1.0.0-dev libavahi-client-dev avahi-daemon avahi-utils

WORKDIR /app/src

RUN git clone https://github.com/libimobiledevice/libplist.git \
&& cd /app/src/libplist \
&& ./autogen.sh \
&& make \
&& make install

RUN git clone https://github.com/libimobiledevice/libimobiledevice-glue.git \
&& cd /app/src/libimobiledevice-glue \
&& ./autogen.sh \
&& make \
&& make install

RUN git clone https://github.com/libimobiledevice/libtatsu.git \
&& cd /app/src/libtatsu \
&& ./autogen.sh \
&& make \
&& make install

RUN git clone https://github.com/libimobiledevice/libusbmuxd.git \
&& cd /app/src/libusbmuxd \
&& ./autogen.sh \
&& make \
&& make install

RUN git clone https://github.com/libimobiledevice/libimobiledevice.git \
&& cd /app/src/libimobiledevice \
&& ./autogen.sh \
&& make \
&& make install

RUN git clone https://github.com/tihmstar/libgeneral.git \
&& cd /app/src/libgeneral \
&& ./autogen.sh \
&& make \
&& make install

RUN git clone https://github.com/fosple/usbmuxd2.git \
&& cd /app/src/usbmuxd2 \
&& apt-get install -y clang \
&& ./autogen.sh \
&& ./configure CC=clang CXX=clang++ \
&& make \
&& make install

RUN apt-get install -y avahi-daemon dbus && apt-get clean
COPY backup.sh /app/backup.sh
COPY pair.sh /app/pair.sh

WORKDIR /app/
ENTRYPOINT ["bash", "-c"]
CMD ["service dbus start && service avahi-daemon start && sleep infinity"]
