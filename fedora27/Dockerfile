FROM fedora:27
ADD dnf-transaction.txt /tmp/dnf-transaction.txt
RUN dnf -y shell /tmp/dnf-transaction.txt
RUN rm -fv /tmp/dnf-transaction.txt
RUN wget -O /tmp/get-pip.py https://bootstrap.pypa.io/get-pip.py && python /tmp/get-pip.py
RUN pip install git+https://github.com/rh-fmk/skt
CMD ["/bin/bash", "-c"]
