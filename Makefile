# https://stackoverflow.com/questions/52310599/what-does-minikube-docker-env-mean
#
# DELETE mysql deployment because it keep data and ip from older sessions 
# https://stackoverflow.com/questions/53246290/nginx-keeps-redirecting-to-some-weird-default-port-other-than-80-443-using-wor
#
# EACH TERMINAL USED WITH MINIKUBE SHOULD ALWAYS BE UP TO DATE DOCKER -ENV !!!!!!!!!!!!!!!! fuck i spent on it 3 days
all:
	eval $$(minikube docker-env)	
	cd ~/coding/services/images/mysql && $(MAKE) b
	cd ~/coding/services/images/nginx && $(MAKE) b
	cd ~/coding/services/images/mysql && $(MAKE) b
	cd ~/coding/services/images/pma/orig && $(MAKE) b
	kube apply -f phpmyadmin.yaml
cl:
	eval $$(minikube docker-env)	
	docker rmi -f $$(docker images --filter "dangling=true" -q) # deleting all images with <none> tag
cls: 
	kubectl get storageclass








# TOPTARGETS := all clean

# SUBDIRS := $(wildcard */.)

# $(TOPTARGETS): $(SUBDIRS)
# $(SUBDIRS):
#         $(MAKE) -C $@ $(MAKECMDGOALS)

# .PHONY: $(TOPTARGETS) $(SUBDIRS)

# .PHONY: all env
