#/bin/bash

sudo service tomcat-myyellowbrick stop;

pushd /usr/share/tomcat02/webapps/
sudo rm -rf MyYellowbrick  MyYellowbrick.war ../work/
sudo cp /tmp/MyYellowbrick.war .
popd

sudo service tomcat-myyellowbrick start
