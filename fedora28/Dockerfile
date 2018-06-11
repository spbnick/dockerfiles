FROM fedora:28
ADD beaker-client-Fedora.repo /etc/yum.repos.d/
RUN echo "fastestmirror=true" >> /etc/dnf/dnf.conf
ADD dnf-transaction.txt /tmp/dnf-transaction.txt
RUN dnf -y shell /tmp/dnf-transaction.txt && \
      dnf clean all && \
      rm -fv /tmp/dnf-transaction.txt
RUN pip install -U pip setuptools

# Allow the container to work as a Jenkins slave
COPY jenkins-slave /usr/local/bin/jenkins-slave
RUN chmod a+x /usr/local/bin/jenkins-slave
ARG VERSION=3.19
ARG AGENT_WORKDIR=/home/jenkins/agent
RUN curl -# --create-dirs -Lo /usr/share/jenkins/slave.jar https://repo.jenkins-ci.org/public/org/jenkins-ci/main/remoting/${VERSION}/remoting-${VERSION}.jar \
  && chmod 755 /usr/share/jenkins \
  && chmod 644 /usr/share/jenkins/slave.jar
RUN useradd -u 10000 -g 10000 jenkins
USER jenkins
ENV AGENT_WORKDIR=${AGENT_WORKDIR}
RUN mkdir /home/jenkins/.jenkins && mkdir -p ${AGENT_WORKDIR}
VOLUME /home/jenkins/.jenkins
VOLUME ${AGENT_WORKDIR}
WORKDIR /home/jenkins
ENTRYPOINT ["jenkins-slave"]
