FROM ubuntu:focal
COPY ipc-orchid-x86_64*.deb /inst/
COPY preseeds.txt /inst/
RUN debconf-set-selections /inst/preseeds.txt
RUN apt-get update
RUN ORCHID_INSTALL_IGNORE_INIT=1 DEBIAN_FRONTEND=noninteractive \
    apt-get install -y /inst/ipc-orchid-x86_64*.deb || true

FROM ubuntu:focal
COPY --from=0 --chown=1000:1000 /opt/orchid /opt/orchid
EXPOSE 8080
EXPOSE 5554
VOLUME /orchives
VOLUME /var/lib/orchid_server
ENV GST_PLUGIN_SCANNER=/opt/orchid/libexec/gstreamer-1.0
WORKDIR /opt/orchid
RUN adduser orchid
RUN mkdir /var/log/orchid_server
RUN chown -R orchid:orchid /var/log/orchid_server
USER orchid
CMD /opt/orchid/bin/orchid_server -c /etc/opt