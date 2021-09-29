#!/bin/bash

#=================================================
# COMMON VARIABLES
#=================================================

# dependencies used by the app
#pkg_dependencies_x86="libavahi-client3 libavahi-common3 libc6 libdbus-1-3 libssl1.1 libstdc++6 liburiparser1 zlib1g dvb-apps bzip2"
pkg_dependencies_arm="libavahi-client3 libavahi-common3 libavcodec58 libavformat58 libavfilter7 libavformat58 \
                      libavresample4 libavutil56 libc6 libdbus-1-3 libdvbcsa1 libhdhomerun4 libssl1.1 liburiparser1 zlib1g  \
                      adduser lsb-base dvb-apps"
                      
tvheadend-data_deb_url="https://github.com/siwinter/tvheadend_ynh/raw/master/sources/tvheadend-data_4.2.8-dmo1_all.deb"
dtv-scan-tables_deb_url="https://github.com/siwinter/tvheadend_ynh/raw/master/sources/dtv-scan-tables_0%2Bgit20190925.6d01903-0.1%7Edeb10u1_all.deb"

tvheadend_url="https://github.com/siwinter/tvheadend_ynh/raw/master/sources/tvheadend_4.2.8-dmo1_armhf.zip"
tvheadend_url="

myynh_install() {
    
    #=================================================
    # INSTALL DEPENDENCIES
    #=================================================
    ynh_script_progression --message="Installing dependencies..." --weight=44

    if [ -n "$(uname -m | grep arm)" ]
    then
        ynh_install_app_dependencies $pkg_dependencies_arm
    else
        ynh_install_app_dependencies $pkg_dependencies_x86
    fi
    
    #=================================================
    # DOWNLOAD TVHEADEND DEB PACKAGE
    #=================================================
    ynh_script_progression --message="Downloading Tvheadend..." --weight=5
    
    temp_folder="$(mktemp -d)"
    tvheadend_deb_dst="$temp_folder/tvheadend_deb.deb"
    
    ynh_exec_quiet "wget -q -O $tvheadend_deb_dst https://github.com/siwinter/tvheadend_ynh/raw/master/sources/tvheadend-data_4.2.8-dmo1_all.deb"
    ynh_exec_quiet "wget -q -O $tvheadend_deb_dst https://github.com/siwinter/tvheadend_ynh/raw/master/sources/dtv-scan-tables_0%2Bgit20190925.6d01903-0.1%7Edeb10u1_all.deb"
    
    ynh_exec_quiet "wget -q -O $tvheadend_deb_dst https://github.com/siwinter/tvheadend_ynh/raw/master/sources/tvheadend-data_4.2.8-dmo1_all.deb"
    
    
}
