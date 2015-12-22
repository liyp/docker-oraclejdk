FROM debian:jessie

MAINTAINER liyp <liyp.yunpeng@gmail.com>

ENV \
  JAVA_VERSION=8 \
  JAVA_UPDATE=65 \
  JAVA_BUILD=17 \
  JAVA_HOME=/opt/jdk

RUN \
  echo "deb http://mirrors.163.com/debian/ jessie main non-free contrib" > /etc/apt/sources.list && \
  apt-get update && apt-get -y upgrade && \
  apt-get install -y wget

RUN \
  cd /tmp && \
  wget --header "Cookie: oraclelicense=accept-securebackup-cookie;" \
          "http://download.oracle.com/otn-pub/java/jdk/${JAVA_VERSION}u${JAVA_UPDATE}-b${JAVA_BUILD}/jdk-${JAVA_VERSION}u${JAVA_UPDATE}-linux-x64.tar.gz" && \
  tar xzf "jdk-${JAVA_VERSION}u${JAVA_UPDATE}-linux-x64.tar.gz" -C /opt && \
  ln -s "/opt/jdk1.${JAVA_VERSION}.0_${JAVA_UPDATE}" $JAVA_HOME

RUN \
  apt-get remove -y wget && apt-get -y autoremove && apt-get -y autoclean && \
  rm /tmp/*

ENV PATH=$JAVA_HOME/bin:$PATH
