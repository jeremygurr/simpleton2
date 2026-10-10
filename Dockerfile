ARG ALPINE_IMAGE=alpine:3.23

FROM $ALPINE_IMAGE

USER root

ARG NO_PROXY=
ARG HTTPS_PROXY=
ARG HTTP_PROXY=
ARG ALPINE_REPO=https://dl-cdn.alpinelinux.org/alpine/

RUN sed -i "s@https://dl-cdn.alpinelinux.org/alpine/@$ALPINE_REPO@g" /etc/apk/repositories 

ENV LANG=en_US.UTF-8
ENV LANGUAGE=en_US.en
ENV LC_ALL=en_US.UTF-8

RUN ln -s /var/cache/apk /etc/apk/cache 

RUN --mount=type=cache,target=/var/cache/apk \
  apk --allow-untrusted add \
    alpine-conf \
    apk-tools-doc \
    bash \
    bash-completion \
    bash-completion-doc \
    bash-doc \
    bc \
    bc-doc \
    bind-tools \
    binutils \
    busybox \
    busybox-doc \
    $end_of_packages

RUN --mount=type=cache,target=/var/cache/apk \
  apk --allow-untrusted add \
    ca-certificates-doc \
    coreutils \
    coreutils-doc \ 
    curl \
    curl-doc \
    dnsmasq \
    dnsmasq-doc \
    docker \
    docs \
    expat-doc \
    file \
    file-doc \
    findutils \
    findutils-doc \
    fstrm-doc \
    $end_of_packages

RUN --mount=type=cache,target=/var/cache/apk \
  apk --allow-untrusted add \
    git \
    git-doc \
    git-perl \
    grep \
    grep-doc \
    ifupdown-ng \
    ifupdown-ng-doc \
    iproute2 \
    jq \
    jq-doc \
    json-c-doc \
    less \
    less-doc \
    libcap-ng-doc \
    libedit-doc \
    libretls-doc \
    libxml2-doc \
    linux-pam-doc \
    $end_of_packages

RUN --mount=type=cache,target=/var/cache/apk \
  apk --allow-untrusted add \
    man-pages \
    mandoc \
    mandoc-doc \
    musl-locales \
    net-tools \
    net-tools-doc \
    openjdk21 \
    openrc \
    openrc-bash-completion \
    openrc-doc \
    openssh \
    openssh-doc \
    openssl \
    pciutils \
    pcre-doc \
    pcre2-doc \
    pkgconf-doc \
    procps \
    readline-doc \
    rsync \
    $end_of_packages

RUN --mount=type=cache,target=/var/cache/apk \
  apk --allow-untrusted add \
    skalibs-doc \
    source-highlight \
    source-highlight-doc \
    strace \
    strace-doc \
    sudo \
    sudo-doc \
    tar \
    tar-doc \
    texinfo \
    texinfo-doc \
    tzdata \
    usbutils \
    $end_of_packages

RUN --mount=type=cache,target=/var/cache/apk \
  apk --allow-untrusted add \
    util-linux \
    util-linux-doc \
    utmps-doc \
    utmps-openrc \
    vim \
    vimdiff \
    vim-doc \
    yq \
    zlib-doc \
    $end_of_packages

ENV HOME=/home
ENV PAGER=less
ENV REPO_CACHE=/home/.m2/repository

RUN adduser -h /home -s /bin/bash -D ai -u 99999
COPY inputrc /etc/
RUN mkdir -p $REPO_CACHE

ARG TIME_ZONE=UTC
RUN setup-timezone -z $TIME_ZONE
ENV TIME_ZONE=$TIME_ZONE

RUN mkdir -p $HOME/scripts $HOME/.ssh /work
RUN chmod 700 $HOME/.ssh
RUN chown -R ai $HOME /work
RUN rm /etc/motd

WORKDIR /work
CMD [ "/bin/bash" ]

