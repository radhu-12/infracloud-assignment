# Infracloud-Assignment 
This solution below will help you to get the csvserver running on your machine . It will address all the errors which came across while setting the application up and how to resolve them. Application uses docker, docker-compose for deployment and prometheus for monitoring the application.

### Part -1

#### 1. Run the container image:

`docker run -d infracloudio/csvserver:latest`

This command will give error because we have not mounted the volumes correctly and it will give file not found error(inputdata),
 we will do that in the next step

#### 2.  Bash script (gencsv.sh)

 ```filename=inputFile
 > $filename
 for (( value=1 ; value <=10 ; value++ ))
 do
 echo $value,$RANDOM >> $filename
 done 
 ```
 #### 3. To run the container in background with inputFile generated ,-v option is using for volume mapping of host directory and docker container directory,run the below command : 

`docker run -d -v /root/csvserver/solution/inputFile:/csvserver/inputdata infracloudio/csvserver:latest`

#### 4. To stop the running container :
`docker stop {container_name} `

#### 5. To check on which port application is listening ,run:
 `netstat -tulnp`

#### 6. To run application on port 9393,perform port mapping using below command :

`docker run -d -p 9393:9300 -v /root/csvserver/solution/inputFile:/csvserver/inputdata infracloudio/csvserver:latest`

#### 7. To set environment variable to orange , -e option is used to set the environment variable ,run the below command :

`docker run -d -p 9393:9300 -e CSVSERVER_BORDER='Orange' -v /root/csvserver/solution/inputFile:/csvserver/inputdata infracloudio/csvserver:latest`

### Part -2
#### docker-compose.yaml 
```
version: '3'
services:
prometheus:
    image: prom/prometheus:latest
    user: root
    container_name: prometheus
    ports:
    - 9090:9090
    volumes:
    - ./prometheus.yml:/etc/prometheus/prometheus.yml
    depends_on:
    - web
  web:
    image: infracloudio/csvserver:latest
    ports:
    - 9393:9300
    environment:
    - CSVSERVER_BORDER=Orange
    volumes:
    - /root/infracloud-assignment/inputFile:/csvserver/inputdata
```
Run : `docker-compose up` to run the application using docker compose.

### Part -3
#### To delete containers run ,
`docker rm {container_name}`

Add the below configuration to docker-compose to yaml file to set up prometheus :
```
version: '3'
services:
  prometheus:
    image: prom/prometheus:latest
    user: root
    container_name: prometheus
    ports:
    - 9090:9090
    volumes:
    - ./prometheus.yml:/etc/prometheus/prometheus.yml
    depends_on:
    - web
  web:
    image: infracloudio/csvserver:latest
    ports:
    - 9393:9300
    environment:
    - CSVSERVER_BORDER=Orange
    volumes:
    - /root/infracloud-assignment/inputFile:/csvserver/inputdata
```
Create a new file for prometheus config ,named prometheus.yml and add the below config to allow prometheus to capture csvserver's metrics.
#### prometheus.yml
```
scrape_configs:
- job_name: prom
  scrape_interval: 5s
  static_configs:
    - targets: ['192.168.0.8:9393']
```
Check https://localhost:9090 , prometheus should be accessible at port 9090 / if using docker playground 9090 will be highlighted and one can access the application by clicking on it.




