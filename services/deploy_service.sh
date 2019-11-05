#/bin/bash

# usage ./deploy_service SERVICE_NAME SOURCE_LOCATION DST_LOCATION
# sudo /tmp/deploy_service.sh yb-payment-service /tmp/yb_payment_service/ /usr/share/yb-payment-service/

SERVICE_NAME=$1
SOURCE_LOCATION=$2
DST_LOCATION=$3

sudo service $SERVICE_NAME stop;

if [ -d "$DST_LOCATION" ]; then
    echo "$DST_LOCATION already exist ..."
    sudo rm -rf $DST_LOCATION
fi
rm /etc/init.d/$SERVICE_NAME

sudo mkdir -p $DST_LOCATION

cp -r $SOURCE_LOCATION/* $DST_LOCATION/
cp $DST_LOCATION/service/$SERVICE_NAME /etc/init.d

sudo service $SERVICE_NAME start
