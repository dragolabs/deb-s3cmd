#!/bin/bash -e
#
# Author: Vitaly Shishlyannikov <vitaly@dragolabs.org>
# Install and package s3cmd using FPM (https://github.com/jordansissel/fpm)
# http://s3tools.org/s3cmd
#


usage() { echo "Usage: $0 [-m maintainer] [-o org-prefix] [-v version_of_s3cmd]

Example: $0 -m 'John Smith' -o 'my_org' -v 1.5.1.2" 1>&2; exit 1; }

# get options
while getopts v:m:o:h option
do
  case "${option}"
  in
    v) VERSION=${OPTARG};;
    m) MAINTAINER=${OPTARG};;
    o) ORG_PREFIX=${OPTARG};;
    h) usage;;
  esac
done

if [ ! `which fpm` ]; then
  echo "I can't find fpm. Try 'gem install fpm'"
  exit 128
fi

# Set workspace
[ -z $WORKSPACE ] && WORKSPACE=`(cd "$(dirname "${0}")"; echo $(pwd))`

# Set defaults
[ -z ${ORG_PREFIX} ] && ORG_PREFIX='debian'
[ -z ${MAINTAINER} ] && MAINTAINER="`whoami`@`hostname`"
[ -z ${VERSION} ] && VERSION='1.5.1.2'


# Vars
INSTALL_DIR="${WORKSPACE}/install_dir"
SRC_DIR="${WORKSPACE}/source_dir"
CONTROL_DIR="${WORKSPACE}/control"
PKG_NAME='s3cmd'
ITERATION="${ORG_PREFIX}`date +%y%m%d%H%M`"


mkdir -p ${INSTALL_DIR} ${SRC_DIR}

# Download and untar
wget https://github.com/s3tools/s3cmd/archive/v${VERSION}.tar.gz -P ${SRC_DIR}
tar xzvf ${SRC_DIR}/v${VERSION}.tar.gz -C ${SRC_DIR}

# Complile, install
cd ${SRC_DIR}/${PKG_NAME}-${VERSION}
S3CMD_PACKAGING=1 python setup.py install --no-compile \
   --root ${INSTALL_DIR} \
   --install-lib /usr/share/s3cmd \
   --install-scripts /usr/share/s3cmd

mkdir -p ${INSTALL_DIR}/usr/bin
cd ${INSTALL_DIR}/usr/bin
ln -s ../share/s3cmd/s3cmd s3cmd

cd ${WORKSPACE}

# Build package
fpm --force \
    -s dir \
    -t deb \
    --license GPLv2 \
    --vendor ${ORG_PREFIX} \
    --maintainer "${MAINTAINER}" \
    --deb-user root \
    --deb-group root \
    --url http://s3tools.org/s3cmd \
    --version $VERSION \
    --iteration ${ITERATION} \
    -C ${INSTALL_DIR} \
    --description 'Command Line S3 Client and Backup for Linux and Mac' \
    --name 's3cmd' \
    --package s3cmd-VERSION-${ITERATION}-ARCH.deb \
    .
