FROM centos:7

RUN yum -y update && \
    yum -y install deltarpm && \
    yum -y install centos-release-scl && \
    yum -y install devtoolset-6 && \
    yum groupinstall -y 'Development Tools' && \
    yum install -y rh-python36
