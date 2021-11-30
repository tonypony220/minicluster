SHELL = /bin/bash
img = img_ftp
del: 
	-docker rm -f $$(docker ps | grep ${img} | cut -c1-12)
	-docker rmi $$(docker images | grep ${img} | cut -c23-37) 
rmp: 
	-docker rm -f $$(docker ps | grep ${img} | cut -c1-12)
b: 
	docker build -t ${img} .
run:
	docker run -dt 				  \
	 -p 8083:21 				  \
	 -e INFLUX_URL=127.0.0.1:8086 \
     -e USERS="one|1234" 		  \
     -e ADDRESS=localhost  \
	 ${img} # PMA_HOST=localhost

     # -p 21000-21010:21000-21010   \
	 #
ex: 
	docker exec -it $$(docker ps | grep ${img} | cut -c1-12) /bin/sh
re: del b run ex

#https://stackoverflow.com/questions/41322541/rebuild-docker-container-on-file-changes

# docker inspect $(docker ps -aq) | grep '"IPAddress"' | head -n 1
# https://stackoverflow.com/questions/41322541/rebuild-docker-container-on-file-changes
