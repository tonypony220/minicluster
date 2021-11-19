# https://stackoverflow.com/questions/52310599/what-does-minikube-docker-env-mean
#
# DELETE mysql deployment because it keep data and ip from older sessions 
# https://stackoverflow.com/questions/53246290/nginx-keeps-redirecting-to-some-weird-default-port-other-than-80-443-using-wor
#
# EACH TERMINAL USED WITH MINIKUBE SHOULD ALWAYS BE UP TO DATE DOCKER -ENV !!!!!!!!!!!!!!!! fuck i spent on it 3 days
all:
	eval $$(minikube docker-env)	
	cd ~/coding/services/images/mysql 	 && $(MAKE) b
	cd ~/coding/services/images/nginx 	 && $(MAKE) b
	cd ~/coding/services/images/wp    	 && $(MAKE) b
	cd ~/coding/services/images/pma/orig && $(MAKE) b

apply: 
	kubectl apply -f phpmyadmin.yaml
	kubectl apply -f wp.yaml
	kubectl apply -f mysql.yaml
	kubectl apply -f nginx.yaml
	kubectl apply -f metallb.yaml
	# see what changes would be made, returns nonzero returncode if different
	kubectl get configmap kube-proxy -n kube-system -o yaml | \
	sed -e "s/strictARP: false/strictARP: true/" | \
	kubectl diff -f - -n kube-system
	# actually apply the changes, returns nonzero returncode on errors only
	kubectl get configmap kube-proxy -n kube-system -o yaml | \
	sed -e "s/strictARP: false/strictARP: true/" | \
	kubectl apply -f - -n kube-system

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
