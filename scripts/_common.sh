#!/bin/bash

#=================================================
# COMMON VARIABLES
#=================================================

# dependencies used by the app
#pkg_dependencies_x86="libavahi-client3 libavahi-common3 libc6 libdbus-1-3 libssl1.1 libstdc++6 liburiparser1 zlib1g dvb-apps bzip2"
pkg_dependencies_arm="libavahi-client3 libavahi-common3 libavcodec58 libavformat58 libavfilter7 libavformat58 \
                      libavresample4 libavutil56 libc6 libdbus-1-3 libdvbcsa1 libhdhomerun4 libssl1.1 liburiparser1 zlib1g  \
                      tvheadend-data adduser lsb-base dvb-apps dtv-scan-tables"

# deb package URLs
tvheadend_deb_x86_64="../sources/tvheadend_4.2.8-dmo1_amd64.deb"
tvheadend_deb_arm="../sources/tvheadend_4.2.8-dmo1_armhf.deb.deb"
tvheadend_data="tvheadend-data_4.2.8-dmo1_all.deb"
dtv_scan_tables="dtv-scan-tables_0+git20190925.6d01903-0.1~deb10u1_all.deb"
