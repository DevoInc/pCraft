FROM debian:bullseye
MAINTAINER Sebastien Tricaud
ARG DEBIAN_FRONTEND=noninteractive
RUN apt update -q
RUN apt -qy install wget jed vim emacs-nox git
RUN apt -qy install tshark 
RUN apt -qy install g++ cmake pybind11-dev python3-dev flex bison libavro-dev uuid-dev libcsv-dev
RUN apt -qy install python3-pip python3-scapy python3-pystache python3-geoip2 python3-yaml python3-avro python3-dnspython
RUN apt -qy install ipython3 nmap pkg-config sudo bsdmainutils graphviz
RUN useradd -ms /bin/bash pcraft
RUN echo "pcraft ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers
ADD runme.1st /
WORKDIR /opt/
RUN git clone --single-branch --branch main https://github.com/devoinc/pcraft pcraft
WORKDIR /opt/pcraft/
RUN pip3 install -r requirements.txt 
RUN mkdir /opt/pcraft/ami/build
WORKDIR /opt/pcraft/ami/build
RUN cmake ..
RUN make
RUN cp /opt/pcraft/ami/build/python/pyami.cpython*.so /opt/pcraft/
WORKDIR /opt/pcraft/ccraft/
RUN make
RUN echo "/opt/pcraft/ami/build/lib/" > /etc/ld.so.conf.d/ami.conf
RUN ldconfig
RUN chown -R pcraft:pcraft /opt/pcraft
USER pcraft
WORKDIR /home/pcraft
RUN mkdir -p /opt/pcraft/.emacs.d/ami
RUN cp /opt/pcraft/ami/editors/emacs/ami-mode.el /opt/pcraft/.emacs.d/ami/
RUN echo "(global-display-line-numbers-mode)" > /opt/pcraft/.emacs.d/init.el
RUN echo "(add-to-list 'load-path \"/opt/pcraft/.emacs.d/ami/\")" >> /opt/pcraft/.emacs.d/init.el
RUN echo "(load \"ami-mode\")" >> /opt/pcraft/.emacs.d/init.el
ENTRYPOINT ["/runme.1st"]
