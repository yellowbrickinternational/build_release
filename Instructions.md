RELEASE Migration brickparking

# Step 1

Stop all tomcat instances

# Step 2

opschonen applicatie:

* Bewaar logs op backup locatie
* Bewaar oude versie op backup locatie
 * Verwijder de applicatie in de webapps folder

-Maak work verwijder alles onder de work directory , work moet blijven staan. BELANGRIJK!!
-Plaats uitgepakte applicatie map in de webapps directory.


## Database

* export BRICKPARKING schema

Run following sequence:

* Copy liquibase folder into production environment
* Apply Liquibase.properties so that connection is done with the right database.

* Execute billing liquibase rollout
  ```sh
      lb_update master.ae7df052683cd677df25fa38a6e3176d3937ff24 DE_BRICKPARKING DE_MUNICIPALITY
      lb_update master.ae7df052683cd677df25fa38a6e3176d3937ff24 BE_BRICKPARKING BE_MUNICIPALITY
      lb_update master.ae7df052683cd677df25fa38a6e3176d3937ff24 TELEPAY NL_MUNICIPALITY
     ```

* Execute brickparking liquibase rollout
  * do the rollout
    ```sh
      lb_update master.83235110a079645354f1d89e8133b219283eaf4d DE_BILLING DE_MUNICIPALITY
      lb_update master.83235110a079645354f1d89e8133b219283eaf4d BE_BILLING BE_MUNICIPALITY
      lb_update master.83235110a079645354f1d89e8133b219283eaf4d NL_BILLING NL_MUNICIPALITY
     ```
    

# Services

  * yb_cronjobservice: Server-2
  * yb_payment_service: Server-1
  There is a script under: services/deploy_service.sh
  ```shell
  usage ./deploy_service.sh SERVICE_NAME SOURCE_LOCATION DST_LOCATION
  /tmp/deploy_service.sh yb-payment-service /tmp/yb_payment_service/ /usr/share/yb-payment-service/
  ```


# Step 4
  plaats alles wat onder de map server configuration zit naar de var directory.
  resultaat is dan /var/brickparking


# Step 5

zet de rechten goed.
chown tomcatXX:tomcat ssl
tomcat moet lees en schrijfrechten hebben recursief op var/brickparking
tomcat groep moet altijd kunnen schrijven op alle items aangemaakt door een user van de groep tomcat.

voo biling tomcat02 moet er in de context.xml uit de folder webapps/billing/META-INF/context.xml 
gekopieerd worden naar tomcat02/conf/Catalina/localhost/billing.xml
run jobs moet op true staan.

```xml
  <Environment name="main/runAsjobService"
                 value="true"
                 type="java.lang.Boolean"
                 override="false"/>
```

# Step 6

OPSTARTEN alle instanties

# Step 7

 * Run smoke tests

log in op alle drie de instances om te zien of ze alle drie werken.
anders check logs wat er mis is en regel het.
