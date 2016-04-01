FROM centos:centos6

MAINTAINER Albin George

ENV JAVA_VERSION 8u73
ENV BUILD_VERSION b02

RUN \
	yum -y upgrade && \
	yum -y install wget && \
	yum -y install unzip && \
	wget --no-cookies --no-check-certificate --header "Cookie: oraclelicense=accept-securebackup-cookie" "http://download.oracle.com/otn-pub/java/jdk/$JAVA_VERSION-$BUILD_VERSION/jdk-$JAVA_VERSION-linux-x64.rpm" -O /tmp/jdk-8-linux-x64.rpm && \
	yum -y install /tmp/jdk-8-linux-x64.rpm	&& \
	alternatives --install /usr/bin/java java /usr/java/latest/bin/java 200000 && \
	alternatives --install /usr/bin/javaws javaws /usr/java/latest/bin/javaws 200000 && \
	alternatives --install /usr/bin/javac javac /usr/java/latest/bin/javac 200000

ENV JAVA_HOME /usr/java/latest

# install jce files

RUN \
	wget --no-check-certificate -c --header "Cookie: oraclelicense=accept-securebackup-cookie" http://download.oracle.com/otn-pub/java/jce/8/jce_policy-8.zip -O /tmp/jce8.zip && \
	cd /tmp; unzip /tmp/jce8.zip; cp /tmp/UnlimitedJCEPolicyJDK8/*jar $JAVA_HOME/jre/lib/security/; rm -R /tmp/*; cd; 	
	

