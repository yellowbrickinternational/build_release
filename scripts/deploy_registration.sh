#/bin/bash

sudo service tomcat-signup stop;

pushd /usr/share/tomcat03/webapps/
sudo rm -rf Yellowbrick-aanmelden.war Yellowbrick-aanmelden ../work/
sudo cp /tmp/Yellowbrick-aanmelden.war .
popd

sudo service tomcat-signup start
