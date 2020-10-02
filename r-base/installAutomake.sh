#!/bin/bash

VERSION=${1}

if echo $VERSION | grep -q '\..*\..*'; then 
    MAJOR_VERSION=${VERSION%.*}
else 
    MAJOR_VERSION=${VERSION}
fi

function install_automake() {
    wget http://ftp.gnu.org/gnu/automake/automake-$VERSION.tar.gz \
        && tar -xvf automake-$VERSION.tar.gz \
        && cd automake-$VERSION \
        && ./configure --prefix=/usr/local/automake-$VERSION \
        && make \
        && make install \
        && cd .. \
        && rm automake-$VERSION.tar.gz \
        && rm -rf automake-$VERSION \
        && rm -f /usr/local/bin/aclocal-$VERSION \
        && rm -f /usr/local/bin/automake-$VERSION \
        && ln -s /usr/local/automake-$VERSION/bin/aclocal-$MAJOR_VERSION /usr/local/bin/aclocal-$MAJOR_VERSION \
        && ln -s /usr/local/automake-$VERSION/bin/automake-$MAJOR_VERSION /usr/local/bin/automake-$MAJOR_VERSION \
        && echo "Installed automake in version $VERSION"
}

install_automake