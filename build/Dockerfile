FROM rockylinux:9 AS builder

RUN <<EOF
dnf group install -y "Development Tools"
dnf install -y epel-release
dnf install -y --enablerepo=devel \
  apr-devel \
  bison \
  bzip2-devel \
  cmake3 \
  flex \
  gcc \
  gcc-c++ \
  git \
  iproute \
  jq \
  krb5-devel \
  libcurl-devel \
  libevent-devel \
  libxml2-devel \
  libzstd-devel \
  libyaml-devel \
  openssh-clients \
  openssh-server \
  openssl-devel \
  passwd \
  perl-ExtUtils-Embed.noarch \
  perl-ExtUtils-MakeMaker.noarch \
  perl-FindBin.noarch \
  perl-Opcode \
  python3-devel \
  python3-pip \
  python3-psutil \
  python3-psycopg2 \
  python3-pyyaml \
  readline-devel \
  rsync \
  xerces-c-devel \
  zlib-devel \
  procps-ng \
  sshpass \
  fuse \
  lsof \
  xfsprogs \
  iputils \
  libuuid-devel \
  glibc-langpack-en
EOF

ARG WHPG_VERSION=7.3.1-WHPG
RUN <<EOF
git clone --single-branch --branch ${WHPG_VERSION} https://github.com/warehouse-pg/warehouse-pg
cd warehouse-pg
./configure --with-perl \
  --with-python \
  --with-libxml \
  --with-openssl \
  --with-zstd \
  --with-uuid=e2fs \
  --with-gssapi \
  --prefix=/usr/local/whpg
make -j8
make -j8 install
EOF
