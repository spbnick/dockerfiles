FROM centos:7
ADD yum-transaction.txt /tmp/yum-transaction.txt
ADD yum-transaction-compilers.txt /tmp/yum-transaction-compilers.txt
RUN yum -y shell /tmp/yum-transaction.txt && \
      yum -y shell /tmp/yum-transaction-compilers.txt && \
      yum-builddep -y kernel && \
      yum clean all && \
      rm -rf /var/cache/yum && \
      rm -fv /tmp/yum-transaction.txt

# Install skt
RUN wget -O /tmp/get-pip.py https://bootstrap.pypa.io/get-pip.py && python /tmp/get-pip.py
RUN pip install git+https://github.com/rh-fmk/skt

# Allow the container to work as a Jenkins slave
COPY jenkins-slave /usr/local/bin/jenkins-slave
RUN chmod a+x /usr/local/bin/jenkins-slave
ARG VERSION=3.19
ARG AGENT_WORKDIR=/home/jenkins/agent
RUN curl --create-dirs -sSLo /usr/share/jenkins/slave.jar https://repo.jenkins-ci.org/public/org/jenkins-ci/main/remoting/${VERSION}/remoting-${VERSION}.jar \
  && chmod 755 /usr/share/jenkins \
  && chmod 644 /usr/share/jenkins/slave.jar
RUN useradd jenkins
USER jenkins
ENV AGENT_WORKDIR=${AGENT_WORKDIR}
RUN mkdir /home/jenkins/.jenkins && mkdir -p ${AGENT_WORKDIR}
VOLUME /home/jenkins/.jenkins
VOLUME ${AGENT_WORKDIR}
WORKDIR /home/jenkins
ENTRYPOINT ["jenkins-slave"]
