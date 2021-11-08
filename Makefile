clean: 
	docker rm -f $(docker ps -aq)
	# docker run -name container -p 8080:80 -v $(pwd):/usr/share/nginx/html nginx
	# docker run -name container -p 8080:80 -v $(pwd):/usr/share/nginx/html:ro nginx << READOBLY
#
# all: ${NAME}

# clean:
# 	rm -f $(OBJS)

# fclean:	clean
# 	rm -f $(NAME)

# re:		fclean all
