#! /bin/bash
sed s/nginx/mysql/ 	 nginx.json > mysql.json
sed s/nginx/grafana/ nginx.json > grafana.json
