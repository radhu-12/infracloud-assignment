# infracloud-assignment
1. Run the container image:

# docker run -d infracloudio/csvserver:latest 

--This command will give error because we have not mounted the volumes correctly and it will give file not found error(inputdata),
 we will do that in the next step

2.  bash script (gencsv.sh)
--------------------------------------
# filename=inputFile
# > $filename
# for (( value=1 ; value <=10 ; value++ ))
# do
# echo $value,$RANDOM >> $filename
# done
-------------------------------------

3. To run the container in background with inputFile generated : 

# docker run -d -v /root/csvserver/solution/inputFile:/csvserver/inputdata infracloudio/csvserver:latest

4. # docker stop {container_name} -- to stop the container

5. To check on which port application is listening ,run:
 # netstat -tulnp 

6. To run application on port 9393, we perform port mapping using below command :

# docker run -d -p 9393:9300 -v /root/csvserver/solution/inputFile:/csvserver/inputdata infracloudio/csvserver:latest

7. To set environment variable to orange , run below command :

# docker run -d -p 9393:9300 -e CSVSERVER_BORDER='Orange' -v /root/csvserver/solution/inputFile:/csvserver/inputdata infracloudio/csvserver:latest
