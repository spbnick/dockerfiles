FROM fedora:27
ADD dnf-transaction.txt /tmp/dnf-transaction.txt
RUN dnf -y shell /tmp/dnf-transaction.txt && dnf builddep -y kernel && dnf clean all
RUN rm -fv /tmp/dnf-transaction.txt

# Install skt
RUN wget -O /tmp/get-pip.py https://bootstrap.pypa.io/get-pip.py && python /tmp/get-pip.py
RUN pip install git+https://github.com/rh-fmk/skt

# Allow the container to work as a Jenkins slave
RUN ln -s /usr/share/jenkins/webroot/WEB-INF/slave.jar /usr/share/jenkins/slave.jar
RUN wget -O /usr/local/bin/jenkins-slave https://raw.githubusercontent.com/jenkinsci/docker-jnlp-slave/master/jenkins-slave
RUN chmod a+x /usr/local/bin/jenkins-slave
RUN echo "jenkins ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/jenkins
USER jenkins
VOLUME /home/jenkins/.jenkins
WORKDIR /home/jenkins

ENTRYPOINT ["jenkins-slave"]
