#/bin/bash

ENV=$1
echo "Deploying on $ENV"

prepare_directory_structure() {
    mkdir -p webapp/Server-1/tomcat01
    mkdir -p webapp/Server-1/tomcat03
    mkdir -p webapp/Server-1/tomcat04
    mkdir -p webapp/Server-2/tomcat02
    mkdir -p webapp/Server-3/tomcat01
    mkdir -p webapp/Server-3/tomcat02
}

prepare_directory_structure()


#cp $SRC_ROOT/yb_yellowsoap/target/YellowSoap.war webapp/Server-1/tomcat01
#cp $SRC_ROOT/yb_registration/target/Yellowbrick-aanmelden.war webapp/Server-1/tomcat03
#cp $SRC_ROOT/yb_taxameter/target/Taxameter.war webapp/Server-1/tomcat04

#cp $SRC_ROOT/yb_my-yellowbrick/target/MyYellowbrick.war webapp/Server-2/tomcat02

#cp $SRC_ROOT/yb_billing/target/billing.war webapp/Server-3/tomcat01
#cp $SRC_ROOT/yb_billing/target/billing.war webapp/Server-3/tomcat02

copy_service() {
    rm -rf `pwd`/services/$1
    $SRC_ROOT/services/$1/package.sh $SRC_ROOT/services/$1/  `pwd`/services/$1 $ENV

    ssh $2 "rm -rf /tmp/$1"
    scp -r `pwd`/services/$1 $2:/tmp
}

#echo "copy services ..."
#copy_service "yb_cronjobservice" $ENV"2"
#copy_service "yb_payment_service" $ENV"1"

pushd webapp
for server in `ls -1 | cut -d'-' -f 2`;
do
    CURRENT_SERVER="Server-"$server
    pushd $CURRENT_SERVER
        for tomcat in `ls -1 | cut -d'-' -f 2`;
        do
            echo $tomcat
            scp $tomcat/*.war $ENV$server:/tmp
        done;
    popd
done;
popd
