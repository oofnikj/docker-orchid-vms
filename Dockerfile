FROM ubuntu:18.04
ARG VERSION
WORKDIR /inst
COPY preseeds.txt .
RUN debconf-set-selections /inst/preseeds.txt
RUN apt-get update && apt-get install -y wget
RUN wget https://download.ipconfigure.com/orchid/ipc-orchid-x86_64_${VERSION}-sysvinit.deb
RUN ORCHID_INSTALL_IGNORE_INIT=1 DEBIAN_FRONTEND=noninteractive \
    apt-get install -y /inst/ipc-orchid-*.deb || true

FROM ubuntu:18.04
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