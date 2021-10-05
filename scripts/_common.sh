#!/bin/bash

#=================================================
# COMMON VARIABLES
#=================================================

sources_url="https://github.com/siwinter/tvheadend_ynh/raw/master/sources"

# set dependencies and url of tvhead due to architecture 
if [ -n "$(uname -m | grep arm)" ]
    then
        pkg_dependencies="libavahi-client3 libavahi-common3 libavcodec58 libavformat58 libavfilter7 libavformat58 \
                      libavresample4 libavutil56 libc6 libdbus-1-3 libdvbcsa1 libhdhomerun4 libssl1.1 liburiparser1 zlib1g  \
                      adduser lsb-base dvb-apps"
                      
        tvheadend_zip_url="$sources_url/tvheadend_4.2.8-dmo1_armhf.zip"
    else
        pkg_dependencies="libavahi-client3 libavahi-common3 libc6 libdbus-1-3 libssl1.1 libstdc++6 liburiparser1 zlib1g \
                      dvb-apps bzip2"
                      
        tvheadend_zip_url="$sources_url/tvheadend_4.2.8-dmo1_amd64.zip"
fi

tvheadend_data_deb_url="$sources_url/tvheadend-data_4.2.8-dmo1_all.deb"
dtv_scan_tables_deb_url="$sources_url/dtv-scan-tables_0%2Bgit20190925.6d01903-0.1%7Edeb10u1_all.deb"


myynh_install() {

    # install dependencies
    ynh_install_app_dependencies $pkg_dependencies
    
    # download additional packages to tmp-folder
    temp_folder="$(mktemp -d)"
    tvheadend_data_deb=$temp_folder/tvheadend_data.deb
    dtv_scan_tables_deb="$temp_folder/dtv_scan_tables.deb"
    tvheadend_zip="$temp_folder/tvheadend.zip"
    
    ynh_exec_quiet "wget -q -O $tvheadend_data_deb $tvheadend_data_deb_url"
    ynh_exec_quiet "wget -q -O $dtv_scan_tables_deb $dtv_scan_tables_deb_url"
    ynh_exec_quiet "wget -q -O $tvheadend_zip $tvheadend_zip_url"
    
    # install additional packages
    ynh_exec_warn_less dpkg -i $tvheadend_data_deb $dtv_scan_tables_deb
    
    # unzip tvheadend
    mkdir -p "$final_path"
    unzip -quo $tvheadend_zip -d "$final_path"
    
    #delete tmp-folder
    ynh_secure_remove --file="$temp_folder"
}
