FROM inwt/r-base:3.5.2

COPY aws.config /app/.aws/config

RUN apt-get -y update \
    && apt-get install -y --no-install-recommends \
        openjdk-8-jdk \
        libbz2-dev \
        liblzma-dev \
        libpcre2-dev \
        libmysqlclient-dev \
        libpq-dev \
        awscli \
    && apt-get autoremove -y \
    && apt-get autoclean -y \
    && rm -rf /var/lib/apt/lists/* \
    && R CMD javareconf \
    # dplyr 0.8.2 broken, install 0.8.3 instead
    && Rscript -e "install.packages(\"dplyr\", repos = \"https://mran.microsoft.com/snapshot/2019-09-05\")" \
    && installPackage \
        data.table \
        futile.logger \
        gbm \
        ggplot2 \
        gridExtra \
        lintr \
        lme4 \
        mgcv \
        rJava \
        RMySQL \
        RPostgres \
        tidyr \
    && installGithub \
        INWT/dbtools \
        INWT/mctools \
    && rm -rf /tmp/downloaded_packages/*
