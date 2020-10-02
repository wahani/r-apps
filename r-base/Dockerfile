FROM inwt/r-ver-ubuntu:3.5.2

WORKDIR /app
ENV HOME /app
ENV DEBIAN_FRONTEND noninteractive
ENV OPENBLAS_NUM_THREADS 1
ENV TZ "Europe/Berlin"
ADD . /includes/

RUN mv /includes/INWT-CA.crt /usr/local/share/ca-certificates/ \
    && dpkg-reconfigure ca-certificates \
    && rm /etc/localtime \
    && ln -s /usr/share/zoneinfo/Europe/Berlin /etc/localtime \
    && echo "Europe/Berlin" > /etc/timezone \
    && apt-get -y update \
    && apt-get install -y --no-install-recommends \
        autoconf \
        less \
        libssl-dev \
        libssh2-1-dev \
        libcurl4-openssl-dev \
        libxml2-dev \
        nano \
        rsync \
        tzdata \
        qpdf \
        wget \
        zlib1g-dev \
    && apt-get install -y automake \
    && apt-get autoremove -y \
    && apt-get autoclean -y \
    && rm -rf /var/lib/apt/lists/* \
    # R things
    && chmod +x /includes/*.R \
    && ln -s /usr/local/lib/R/site-library/littler/examples/dratInsert.r /usr/local/bin/dratInsert.r \
    && ln -s /includes/check.R /usr/local/bin/check \
    && ln -s /includes/test.R /usr/local/bin/test \
    && ln -s /includes/build.R /usr/local/bin/build \
    && ln -s /includes/main.R /usr/local/bin/main \
    && ln -s /includes/installGithub.R /usr/local/bin/installGithub \
    && ln -s /includes/installPackage.R /usr/local/bin/installPackage \
    && ln -s /includes/installAutomake.sh /usr/local/bin/installAutomake \
    && Rscript -e "options(warn = 2); install.packages('fs', repos = 'https://mran.microsoft.com/snapshot/2020-09-05')" \
    && Rscript -e "options(warn = 2); install.packages(c('codetools', 'devtools', 'docopt', 'drat', 'modules', 'roxygen2', 'testthat'))" \
    && rm -rf /tmp/downloaded_packages/* \
    && mkdir -p /r-repo/src/contrib \
    && touch /r-repo/src/contrib/PACKAGES \
    && echo "options(repos = c(getOption('repos'), LOCAL = 'file:////r-repo/'))" >> /usr/local/lib/R/etc/Rprofile.site \
    && echo "options(repos = c(getOption('repos'), INWT = 'https://inwt-vmeh2.inwt.de/r-repo/'))" >> /usr/local/lib/R/etc/Rprofile.site \
    && echo "options(dratRepo = '/r-repo/')" >> /usr/local/lib/R/etc/Rprofile.site  \
    && chmod --recursive o+w /usr/local/lib/R/site-library

