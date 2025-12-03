# syntax=docker/dockerfile:1.19.0

FROM public.ecr.aws/amazonlinux/amazonlinux:minimal as linux
RUN dnf install -y \
    autoconf \
    automake \
    binutils \
    curl-devel \
 #   expat \
 #   expat-devel \
    gcc \
    gettext \
    gettext-devel \
    git \
    glibc-static \
    glibc-devel \
    kernel-devel \
    kernel-headers \
    libcurl-devel \
    libstdc++-static \
    libssh2 \
    libssh2-devel \
    openssl \
    openssl-devel \
    pcre \
    pcre-devel \
    perl-devel \
    procps-ng \
    procps-ng-devel \
    util-linux \
    tar \
    tcl \
    tcl-devel \
    wget \
    zlib-static \
    zlib-devel

RUN wget https://www.kernel.org/pub/software/scm/git/git-2.51.2.tar.gz && \
    tar xzf /git-2.51.2.tar.gz
#    wget http://musl.cc/x86_64-linux-musl-cross.tgz && \
#    tar xzf /x86_64-linux-musl-cross.tgz

#ENV PATH="/x86_64-linux-musl-cross/bin:$PATH:/git-core/bin"
ENV PATH="$PATH:/git-core/bin"
#ENV CFLAGS="$CFLAGS -static"

# --build x86_64-linux-musl-cross
RUN mkdir /git-core && \
    cd /git-2.51.2 && \
    ./configure --prefix="/git-core" --with-curl --with-openssl --without-expat && \
    make -j8 install


CMD ["/opt/git-core/bin/git", "--version"]