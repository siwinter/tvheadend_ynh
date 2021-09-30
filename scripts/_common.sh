#!/bin/bash

#=================================================
# COMMON VARIABLES
#=================================================




# dependencies used by the app
#pkg_dependencies_x86="libavahi-client3 libavahi-common3 libc6 libdbus-1-3 libssl1.1 libstdc++6 liburiparser1 zlib1g dvb-apps bzip2"
pkg_dependencies="libavahi-client3 libavahi-common3 libavcodec58 libavformat58 libavfilter7 libavformat58 \
                      libavresample4 libavutil56 libc6 libdbus-1-3 libdvbcsa1 libhdhomerun4 libssl1.1 liburiparser1 zlib1g  \
                      adduser lsb-base dvb-apps"

tvheadend_zip_url="https://github.com/siwinter/tvheadend_ynh/raw/master/sources/tvheadend_4.2.8-dmo1_armhf.zip"
# set dependencies and url of tvhead due to architecture 
#if [ -n "$(uname -m | grep arm)" ]
#    then
#        pkg_dependencies="libavahi-client3 libavahi-common3 libavcodec58 libavformat58 libavfilter7 libavformat58 \
#                      libavresample4 libavutil56 libc6 libdbus-1-3 libdvbcsa1 libhdhomerun4 libssl1.1 liburiparser1 zlib1g  \
#                      adduser lsb-base dvb-apps"
                      
#        tvheadend_zip_url="https://github.com/siwinter/tvheadend_ynh/raw/master/sources/tvheadend_4.2.8-dmo1_armhf.zip"
#    else
#        pkg_dependencies="libavahi-client3 libavahi-common3 libc6 libdbus-1-3 libssl1.1 libstdc++6 liburiparser1 zlib1g \
#                      dvb-apps bzip2"
                      
#        tvheadend_zip_url="https://github.com/siwinter/tvheadend_ynh/raw/master/sources/tvheadend_4.2.8-dmo1_amd64.zip"
#    fi

tvheadend-data_deb_url="https://github.com/siwinter/tvheadend_ynh/raw/master/sources/tvheadend-data_4.2.8-dmo1_all.deb"
dtv-scan-tables_deb_url="https://github.com/siwinter/tvheadend_ynh/raw/master/sources/dtv-scan-tables_0%2Bgit20190925.6d01903-0.1%7Edeb10u1_all.deb"


myynh_install() {
    
    #=================================================
    # INSTALL DEPENDENCIES
    #=================================================
    ynh_script_progression --message="Installing dependencies..." --weight=44
    
    ynh_install_app_dependencies $pkg_dependencies
    
    #=================================================
    # DOWNLOAD TVHEADEND PACKAGES
    #=================================================
    ynh_script_progression --m essage="Downloading Tvheadend..." --weight=5
    
    temp_folder="$(mktemp -d)"
    tvheadend-data_dev_dst="$temp_folder/tvheadend-data.deb"
    dtv-scan-tables_deb_dst="$temp_folder/dtv-scan-tables.deb"
    tvheadend_zip_dest="$temp_folder/tvheadend.zip"
    ynh_exec_quiet "wget -q -O $tvheadend-data_deb_dst $tvheadend-data_deb_url"
    ynh_exec_quiet "wget -q -O $dtv-scan-tables_deb_dst $dtv-scan-tables_deb_url"
    
    ynh_exec_quiet "wget -q -O $tvheadend_zip_dst $tvheadend_zip_url"
    
    #=================================================
    # INSTALL TVHEADEND DEB PACKAGES
    #=================================================
    ynh_script_progression --message="Installing Tvheadend-data..." --weight=24
    ynh_exec_warn_less dpkg -i $tvheadend-data_deb_dst

    ynh_script_progression --message="Installing dtv-scan-tables..." --weight=24
    ynh_exec_warn_less dpkg -i $dtv-scan-tables_deb_dst
    
    #=================================================
    # UNZIP TVHEADEND
    #=================================================
    ynh_script_progression --message="Unzip tvheadend ..." --weight=2
    
    unzip -quo $tvheadend_zip_dst -d "$final_path"
  
    ynh_secure_remove --file="$temp_folder"
}
