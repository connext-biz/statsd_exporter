#!/bin/bash

set -e

PACKAGE_NAME="statsd-exporter"
PACKAGE_VERSION=$(cat VERSION)
PACKAGE_FULLNAME="${PACKAGE_NAME}-${PACKAGE_VERSION}"

echo "Building ${PACKAGE_FULLNAME}.deb..."

if [ ! -e ./statsd_exporter ]; then
	echo "'./statsd_exporter' not found, please run 'make' first"
	exit 1
fi

rm -fr "${PACKAGE_FULLNAME}"
mkdir -p "${PACKAGE_FULLNAME}"

cp -R deb_template/* "${PACKAGE_FULLNAME}"
cp ./statsd_exporter "${PACKAGE_FULLNAME}/usr/bin"

dpkg-deb --build --root-owner-group "${PACKAGE_FULLNAME}"
rm -fr "${PACKAGE_FULLNAME}"

