SHELL = /bin/bash
img = img_mysql
del: 
	-docker rm -f $$(docker ps | grep ${img} | cut -c1-12)
	-docker rmi $$(docker images | grep ${img} | cut -c23-37) 
	# -docker rmi $$(docker images | grep none | cut -c23-37) 
b: 
	docker build -t ${img} .
run:
	docker run -dt 				\
	-e MYSQL_ROOT_PASSWORD=pass	\
	-e MYSQL_DATABASE=app		\
	-e MYSQL_USER=app			\
	-e MYSQL_PASSWORD=app		\
	${img} # PMA_HOST=localhost 
	# -e MYSQL_USER_MONITORING monitoring
	# -e MYSQL_PASSWORD_MONITORING monitoring
ex: 
	docker exec -it $$(docker ps | grep ${img} | cut -c1-12) /bin/sh
re: del b run ex

#https://stackoverflow.com/questions/41322541/rebuild-docker-container-on-file-changes

# docker inspect $(docker ps -aq) | grep '"IPAddress"' | head -n 1
# https://stackoverflow.com/questions/41322541/rebuild-docker-container-on-file-changes
