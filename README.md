# Orchid VMS in Docker

Build and run [Orchid Core VMS](https://www.ipconfigure.com/products/orchid) in Docker.

Build for `armv7l` (Raspberry Pi 32-bit) - currently not working:

    $ export VERSION=2.14.0
    $ docker build -f Dockerfile.rpi -t orchid-vms:${VERSION}-armv7l --build-arg VERSION .

Build for `amd64`:

    $ export VERSION=2.14.0
    $ docker build -t orchid-vms:$VERSION --build-arg VERSION .

Create local directories to store videos and launch:

    $ mkdir -p orchives
    $ mkdir -p orchid_server
    $ docker-compose up -d

Default login is `admin:password123`. This password should be reset on first login.