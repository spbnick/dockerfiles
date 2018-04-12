FROM centos:7
ADD yum-transaction.txt /tmp/yum-transaction.txt
RUN yum -y shell /tmp/yum-transaction.txt
RUN yum-builddep -y kernel
RUN rm -fv /tmp/yum-transaction.txt
RUN wget -O /tmp/get-pip.py https://bootstrap.pypa.io/get-pip.py && python /tmp/get-pip.py
RUN pip install git+https://github.com/rh-fmk/skt
CMD ["/bin/bash", "-c"]
