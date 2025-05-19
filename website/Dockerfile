FROM nginx:alpine

# required for envsubst
RUN apk add --no-cache gettext

COPY src/index.html.tmpl /usr/share/nginx/html/index.html.tmpl
COPY entrypoint.sh /entrypoint.sh

RUN chmod +x /entrypoint.sh

EXPOSE 80

ENTRYPOINT ["/entrypoint.sh"]