FROM rhel:7
ADD beaker-client-RedHatEnterpriseLinux.repo /etc/yum.repos.d/
ADD yum-transaction.txt /tmp/yum-transaction.txt
RUN yum -y install https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm && \
      yum repolist && \
      yum -y shell /tmp/yum-transaction.txt && \
      yum clean all && \
      rm -rf /var/cache/yum && \
      rm -fv /tmp/yum-transaction.txt
RUN pip install -U pip setuptools

# Add CA certificate
ADD rh-ca.crt /etc/pki/ca-trust/source/anchors/
RUN update-ca-trust

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
