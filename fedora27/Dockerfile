FROM fedora:27
ADD dnf-transaction.txt /tmp/dnf-transaction.txt
RUN dnf -y shell /tmp/dnf-transaction.txt && dnf builddep -y kernel
RUN rm -fv /tmp/dnf-transaction.txt

# Install skt
RUN wget -O /tmp/get-pip.py https://bootstrap.pypa.io/get-pip.py && python /tmp/get-pip.py
RUN pip install git+https://github.com/rh-fmk/skt

# Allow the container to work as a Jenkins slave
RUN mkdir /usr/share/jenkins
RUN ln -s /usr/share/java/jenkins-remoting/remoting.jar /usr/share/jenkins/slave.jar
RUN wget -O /usr/local/bin/jenkins-slave https://raw.githubusercontent.com/jenkinsci/docker-jnlp-slave/master/jenkins-slave
RUN chmod a+x /usr/local/bin/jenkins-slave
RUN useradd --system --shell /bin/bash --create-home --home /home/jenkins jenkins
RUN echo "jenkins ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/jenkins
USER jenkins
RUN mkdir -p /home/jenkins/.jenkins
VOLUME /home/jenkins/.jenkins
WORKDIR /home/jenkins

ENTRYPOINT ["jenkins-slave"]
