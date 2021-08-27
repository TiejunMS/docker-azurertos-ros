FROM ubuntu:20.04
RUN dpkg --add-architecture i386 && \
    export DEBIAN_FRONTEND=noninteractive && \
    apt-get update && \
    apt-get install -y \
        sudo \
        cmake \
        gcc-multilib \
        git \
        g++ \
        gcovr \
        ninja-build \
        unifdef \
        libpcap-dev:i386 \
        libcmocka-dev:i386 \
        ethtool \
        python3-pip \
        iproute2 \
        dnsmasq \
        isc-dhcp-server \
        iptables \
        net-tools \
        tofrodos \
        cgdb \
        dos2unix \
        gawk && \
    apt-get install -y \
        git build-essential gcc-arm-none-eabi python3-pip cmake ninja-build \
        libnewlib-arm-none-eabi libstdc++-arm-none-eabi-newlib g++-multilib \
        gcc-multilib binutils-arm-none-eabi && \
    pip3 install git+https://github.com/gcovr/gcovr.git@4.1 cmake && \
    pip3 install catkin_pkg lark-parser empy colcon-common-extensions && \
    rm -rf /var/lib/apt/lists/*

COPY ./scripts/init_vm_network.sh /
COPY ./config/dhcpd.conf /etc/dhcp/dhcpd.conf
COPY ./config/isc-dhcp-server /etc/default/isc-dhcp-server
COPY ./config/.gdbinit /root/

RUN chmod +x /init_vm_network.sh
ENTRYPOINT /init_vm_network.sh && bash

