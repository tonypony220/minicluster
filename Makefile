# https://stackoverflow.com/questions/52310599/what-does-minikube-docker-env-mean
#
# DELETE mysql deployment because it keep data and ip from older sessions 
# https://stackoverflow.com/questions/53246290/nginx-keeps-redirecting-to-some-weird-default-port-other-than-80-443-using-wor
#
# EACH TERMINAL USED WITH MINIKUBE SHOULD ALWAYS BE UPTODATE DOCKER-ENV !!!!!!!!!!!!!!!! fuck i spent on it 3 days
all:
	-eval $$(minikube docker-env)	
	cd images/mysql 	 && $(MAKE) b
	cd images/nginx 	 && $(MAKE) b
	cd images/wp    	 && $(MAKE) b
	cd images/pma/orig   && $(MAKE) b
	cd images/grafana    && $(MAKE) b
	cd images/influxdb   && $(MAKE) b
	cd images/ftp  	     && $(MAKE) b

apply: 
	kubectl apply -f https://raw.githubusercontent.com/kubernetes/dashboard/v2.4.0/aio/deploy/recommended.yaml
	kubectl apply -f phpmyadmin.yaml
	kubectl apply -f wp.yaml
	kubectl apply -f mysql.yaml
	# export EXTERNAL_IP=$(kubectl get services wordpress --output jsonpath='{.status.loadBalancer.ingress[0].ip}') # for redirection in nginx conf
	# envsubst <  nginx.yaml | kube apply -f - # https://skofgar.ch/dev/2020/08/how-to-quickly-replace-environment-variables-in-a-file/
	#
	kubectl apply -f nginx.yaml
	kubectl apply -f metallb.yaml
	kubectl apply -f ftp.yaml
	kubectl apply -f influxdb.yaml
	# https://grafana.com/docs/grafana/latest/administration/provisioning/
	kubectl apply -f grafana.yaml
	# see what changes would be made, returns nonzero returncode if different
#	kubectl get configmap kube-proxy -n kube-system -o yaml | \
#	sed -e "s/strictARP: false/strictARP: true/" | \
#	kubectl diff -f - -n kube-system
	# actually apply the changes, returns nonzero returncode on errors only
	kubectl get configmap kube-proxy -n kube-system -o yaml | \
	sed -e "s/strictARP: false/strictARP: true/" | \
	kubectl apply -f - -n kube-system
	kubectl apply -f dashboard_config.yaml

	# kubectl get services wordpress --output jsonpath='{.status.loadBalancer.ingress[0].ip}'

cl:
	# eval $$(minikube docker-env)	
	docker rmi -f $$(docker images --filter "dangling=true" -q) # deleting all images with <none> tag
cls: 
	kubectl get storageclass
mlb: # reloads metallb
	# https://github.com/metallb/metallb/issues/348
	kubectl delete po -n metallb-system --all
	kubectl apply -f metallb.yaml

dash: # to open dash
	echo "http://localhost:8001/api/v1/namespaces/kubernetes-dashboard/services/https:kubernetes-dashboard:/proxy/#/login" 
	kubectl -n kubernetes-dashboard get secret $$(kubectl -n kubernetes-dashboard get sa/admin-user -o jsonpath="{.secrets[0].name}") -o go-template="{{.data.token | base64decode}}"
	echo 
#	kubectl proxy
#: inspecting health of process 
# docker inspect --format='{{json .State.Health}}' container_name

clean:
	minikube delete
	docker rmi -f $(docker images -aq)





# TOPTARGETS := all clean

# SUBDIRS := $(wildcard */.)

# $(TOPTARGETS): $(SUBDIRS)
# $(SUBDIRS):
#         $(MAKE) -C $@ $(MAKECMDGOALS)

# .PHONY: $(TOPTARGETS) $(SUBDIRS)

# .PHONY: all env
