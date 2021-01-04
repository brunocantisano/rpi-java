FROM balenalib/rpi-raspbian

MAINTAINER Bruno Cardoso Cantisano <bruno.cantisano@gmail.com>

LABEL Description="This image is used as base image for my explorations of running JAVA/Node applications on a Raspberry Pi 2 cluster." Version="0.1"

# Set environment
ENV JAVA_VERSION=8 \
    JAVA_UPDATE=271 \
    JAVA_BUILD=09

# Download and install glibc
RUN apt-get update && \
  apt-get install wget ca-certificates

RUN wget \
    --no-cookies \
    --no-check-certificate \
    --header "Cookie: gpw_e24=http%3a%2F%2Fwww.oracle.com%2Ftechnetwork%2Fjava%2Fjavase%2Fdownloads%2Fjdk8-downloads-2133151.html; oraclelicense=accept-securebackup-cookie;" \
    "https://download.oracle.com/otn-pub/java/jdk/${JAVA_VERSION}u${JAVA_UPDATE}-b${JAVA_BUILD}/61ae65e088624f5aaa0b1d2d801acb16/jdk-${JAVA_VERSION}u${JAVA_UPDATE}-linux-arm32-vfp-hflt.tar.gz"

RUN tar -xzf jdk-${JAVA_VERSION}u${JAVA_UPDATE}-linux-arm32-vfp-hflt.tar.gz \
    && echo "" > /etc/nsswitch.conf \
    && mkdir /usr/lib/jvm \
    && mv jdk1.${JAVA_VERSION}.0_${JAVA_UPDATE} /usr/lib/jvm/jdk-${JAVA_VERSION}-oracle-arm32-vfp-hflt \
    && ln -s /usr/lib/jvm/jdk-${JAVA_VERSION}-oracle-arm32-vfp-hflt/jre/bin/java /usr/bin/java

ENV PATH=$PATH:${PATH}:/usr/lib/jvm/jdk-${JAVA_VERSION}-oracle-arm32-vfp-hflt/bin \
    JAVA_HOME="/usr/lib/jvm/jdk-${JAVA_VERSION}-oracle-arm32-vfp-hflt"

RUN rm -f jdk*.tar.gz /usr/lib/jvm/jdk-${JAVA_VERSION}-oracle-arm32-vfp-hflt/src.zip \
    rm -rf $JAVA_HOME/jre/bin/jjs \
       $JAVA_HOME/jre/bin/keytool \
       $JAVA_HOME/jre/bin/orbd \
       $JAVA_HOME/jre/bin/pack200 \
       $JAVA_HOME/jre/bin/policytool \
       $JAVA_HOME/jre/bin/rmid \
       $JAVA_HOME/jre/bin/rmiregistry \
       $JAVA_HOME/jre/bin/servertool \
       $JAVA_HOME/jre/bin/tnameserv \
       $JAVA_HOME/jre/bin/unpack200

# apk del wget ca-certificates && \
# rm -rf /var/cache/apk/* 

# Define default command.
CMD ["bash"]
