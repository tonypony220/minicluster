SHELL = /bin/bash
img = img_grafana
del: 
	-docker rm -f $$(docker ps | grep ${img} | cut -c1-12)
	-docker rmi $$(docker images | grep ${img} | cut -c23-37) 
rmp: 
	-docker rm -f $$(docker ps | grep ${img} | cut -c1-12)
b: 
	docker build -t ${img} .
run:
	docker run -p 80:3000 -dt -e INFLUX_URL=127.0.0.1:8086 ${img} # PMA_HOST=localhost
runi:
	docker run -it --entrypoint /bin/bash -p 3000:80 -dt -e INFLUX_URL=127.0.0.1:8086 ${img} # PMA_HOST=localhost
ex: 
	docker exec -it $$(docker ps | grep ${img} | cut -c1-12) /bin/sh
re: del b run ex
re: del b runi

