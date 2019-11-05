#/bin/bash

sudo service tomcat-soap stop;

pushd /usr/share/tomcat01/webapps/
sudo rm -rf YellowSoap  YellowSoap.war ../work/
sudo cp /tmp/YellowSoap.war .
popd

sudo service tomcat-soap start
