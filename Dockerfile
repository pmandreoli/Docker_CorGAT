# Galaxy - CorGAT

FROM bgruening/galaxy-stable:19.01

MAINTAINER Pietro Mandreoli, pietro.mandreoli@unimi.it

ENV GALAXY_CONFIG_BRAND="CorGAT"

WORKDIR /galaxy-central

RUN add-tool-shed --url 'http://testtoolshed.g2.bx.psu.edu/' --name 'Test Tool Shed'

RUN wget https://gist.githubusercontent.com/pmandreoli/2a08f107179b2e4879bd55fedeca5668/raw/cbb0727171b6e099f447773f929c2d5d6243253d/galaxy-CorGAT-tool-list.yml -O $GALAXY_ROOT/tools1.yaml

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
