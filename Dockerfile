# Galaxy - CorGAT

FROM bgruening/galaxy-stable:20.05

MAINTAINER Pietro Mandreoli, pietro.mandreoli@unimi.it

ENV GALAXY_CONFIG_BRAND="CorGAT"

RUN apt-get update ; apt-get upgrade -y

RUN apt-get install wget -y

WORKDIR /galaxy-central

RUN add-tool-shed --url 'http://testtoolshed.g2.bx.psu.edu/' --name 'Test Tool Shed'

RUN wget https://raw.githubusercontent.com/matteo14c/CorGAT_galaxy/master/Docker/galaxy-CorGAT-tool-list.yml -O $GALAXY_ROOT/tools1.yaml

RUN /tool_deps/_conda/bin/conda update conda

RUN chown -R 1450:1450 /tool_deps/_conda/pkgs/cache/

RUN install-tools $GALAXY_ROOT/tools1.yaml && \
    /tool_deps/_conda/bin/conda clean --tarballs --yes > /dev/null && \
    rm /export/galaxy-central/ -rf

# Expose port 80, 443 (webserver), 21 (FTP server), 8800 (Proxy), 9002 (supvisord web app)
EXPOSE :21
EXPOSE :80
EXPOSE :443
EXPOSE :8800
EXPOSE :9002

# Autostart script that is invoked during container start
CMD ["/usr/bin/startup"]
# Mark folders as imported from the host.
VOLUME ["/export/", "/data/", "/var/lib/docker"]
