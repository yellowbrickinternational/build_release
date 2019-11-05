#!/bin/bash

for f in `find . -type f -name *.war`;
do
    echo "$f: " `unzip -c "$f" WEB-INF/classes/buildInfo.properties | grep application_feature`
done


#unzip -c tomcat01/YellowSoap.war WEB-INF/classes/buildInfo.properties