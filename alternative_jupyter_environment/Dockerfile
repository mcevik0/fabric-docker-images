# Dockerfile
FROM rockylinux:9
MAINTAINER Paul Ruth <pruth@renci.org>
LABEL maintainer="pruth@renci.org"

#ARG FABLIB_ENV=0.0.1


RUN echo "umask 0000" >> /etc/bashrc 

RUN dnf clean all && rm -rf /var/cache/yum 

RUN dnf install -y epel-release \
 && /usr/bin/crb enable     \
 && dnf clean all           \
 && rm -rf /var/cache/yum 

RUN dnf install -y python3.11 python3.11-devel python3.11-pip python3-pip vim sudo git htop log4j \
 && dnf groupinstall -y "Development Tools" "System Tools" \
 && dnf clean all \    
 && rm -rf /var/cache/yum 

RUN dnf install -y net-tools libibverbs iputils iproute procps \
 && dnf clean all \
 && rm -rf /var/cache/yum 

RUN python3.11 -m pip install --no-cache-dir \
                      fabrictestbed-extensions \
                      SliceCommander \
                      jupyter \
                      jupyterlab \
                      jupyter_contrib_nbextensions \
                      nbconvert \
                      paramiko \
                      bash_kernel \
                      scapy \
                      ipywidgets \
                      ipyleaflet \
                      ipycytoscape \
                      pandas \
                      numpy \
                      rpyc \
                      python-openstackclient \
                      openstacksdk  \
                      python-chi \
                      python-dotenv \
                      elasticsearch \
                      black 

RUN python3.11 -m bash_kernel.install 

RUN useradd -ms /bin/bash fabric 

RUN echo 'fabric ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers 
ADD work /home/fabric/work 

RUN mkdir -p /home/fabric/work/fabric_config 

RUN chown -R fabric:fabric /home/fabric/work 

USER fabric

WORKDIR /home/fabric

RUN git clone https://github.com/fabric-testbed/fabrictestbed-extensions.git 

RUN git clone https://github.com/fabric-testbed/jupyter-examples.git 

WORKDIR /home/fabric/fabrictestbed-extensions

RUN python3.11 -m pip install --no-cache-dir . 

RUN python3.11 -m pip install --no-cache-dir  \
                       python-openstackclient \
                       openstacksdk \
                       pyopenssl \
                       cryptography 

WORKDIR /home/fabric/work

RUN dnf clean all 

ENV JUPYTER_LAB_PORT=8888

ENV JUPYTER_LAB_TOKEN=fabric

ENTRYPOINT jupyter lab --port $JUPYTER_LAB_PORT --NotebookApp.allow_origin='https://colab.research.google.com' --NotebookApp.port_retries=0 --NotebookApp.token=$JUPYTER_LAB_TOKEN --NotebookApp.iopub_data_rate_limit=1.0e10 --no-browser --ip "*" --notebook-dir /home/fabric/work




