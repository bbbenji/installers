#!/usr/bin/env bash
#+----------------------------------------------------------------------------+
#+ ServerAdmin phpMyAdmin Auto-Installer for Ubuntu
#+----------------------------------------------------------------------------+
#+ Author:      Benji
#+ GitHub:      https://github.com/bbbenji/serveradmin-installers
#+ Issues:      https://github.com/bbbenji/serveradmin-installers/issues
#+ License:     GPL v3.0
#+ OS:          Ubuntu 16.04, Ubuntu 16.10
#+ Release:     1.0.0
#+----------------------------------------------------------------------------+

#+----------------------------------------------------------------------------+
#+ The purpose of this script is to automate installation of phpMyAdmin. 
#+----------------------------------------------------------------------------+
clear

#+----------------------------------------------------------------------------+
#+ Check current users ID. If user is not 0 (root), exit.
#+----------------------------------------------------------------------------+
if [ "${EUID}" != 0 ];
then
    echo "ServerAdmin phpMyAdmin Auto-Installer should be executed as the root user."
    exit
fi

#+----------------------------------------------------------------------------+
#+ Pre-Configuration
#+----------------------------------------------------------------------------+
currentPath="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
phpmyadminVers="4.7.4"

#+----------------------------------------------------------------------------+
#+ Setup
#+----------------------------------------------------------------------------+
phpmyadminSetup()
{
    #+------------------------------------------------------------------------+
    #+ 1). Update/Sync Repositories
    #+ 2). Upgrading Existing Packages
    #+ 3). Install Packages for Build Environment
    #+------------------------------------------------------------------------+
    apt-get update \
    && apt-get -y upgrade \
    && apt-get -y install composer

    #+------------------------------------------------------------------------+
    #+ Download & Extract phpMyAdmin
    #+------------------------------------------------------------------------+
    cd /home/nginx/htdocs \
    && wget https://files.phpmyadmin.net/phpMyAdmin/${phpmyadminVers}/phpMyAdmin-${phpmyadminVers}-all-languages.zip \
    && unzip phpMyAdmin-${phpmyadminVers}-all-languages.zip \
    && cd nphpMyAdmin-${phpmyadminVers}-all-languages \
    && composer update --no-dev
}

phpmyadminCleanup()
{
    #+------------------------------------------------------------------------+
    #+ Remove downloaded packages
    #+------------------------------------------------------------------------+
    rm -rf /home/nginx/htdocs/hpMyAdmin-${phpmyadminVers}-all-languages.zip
}