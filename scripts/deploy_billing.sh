#/bin/bash

sudo service tomcat-billing stop;
sudo service tomcat-billing-service stop;

pushd /usr/share/tomcat01/webapps/
sudo rm -rf billing.war billing ../work/
sudo cp /tmp/billing.war .
popd


pushd /usr/share/tomcat02/webapps/
sudo rm -rf billing.war billing ../work/
sudo cp /tmp/billing.war .
popd

sudo service tomcat-billing start;
sudo service tomcat-billing-service start;
