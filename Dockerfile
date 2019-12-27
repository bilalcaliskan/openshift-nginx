FROM nginx:stable-alpine

LABEL io.k8s.display-name="Nginx Web Server" \
      io.k8s.description="A base Nginx image for running Nginx on Openshift" \
      io.openshift.expose-services="8080:http" \
      io.openshift.tags="nginx"
EXPOSE 8080
RUN apk update && apk upgrade --available
ADD conf.d/*.conf /etc/nginx/conf.d/
ADD nginx.conf /etc/nginx/
RUN touch /run/nginx.pid \
    && chgrp -R 0 /run/nginx.pid /var/cache/nginx /var/lib/nginx /var/tmp/nginx \
    && chmod -R g+rwx /run/nginx.pid /var/cache/nginx /var/lib/nginx /var/tmp/nginx
USER 1001
