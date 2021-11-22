SHELL = /bin/bash
img = img_influxdb
del: 
	-docker rm -f $$(docker ps | grep ${img} | cut -c1-12)
	-docker rmi $$(docker images | grep ${img} | cut -c23-37) 
rmp: 
	-docker rm -f $$(docker ps | grep ${img} | cut -c1-12)
b: 
	docker build --progress=plain -t ${img} .
run:
	docker run -p 8086:8086 -dt 	 			   \
			   -e INFLUXDB_ADMIN_PASSWORD=pass 	   \
			   -e INFLUXDB_ADMIN_USER=admin    	   \
				${img} # PMA_HOST=localhost
			   # -e INFLUXDB_DB=db 			   
ex: 
	docker exec -it $$(docker ps | grep ${img} | cut -c1-12) /bin/sh
re: del b run ex

#https://stackoverflow.com/questions/41322541/rebuild-docker-container-on-file-changes

# docker inspect $(docker ps -aq) | grep '"IPAddress"' | head -n 1
# https://stackoverflow.com/questions/41322541/rebuild-docker-container-on-file-changes
