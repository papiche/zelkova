# Dockerfile

FROM nginx:latest

RUN DEBIAN_FRONTEND=noninteractive apt-get update && \
        DEBIAN_FRONTEND=noninteractive apt-get update && apt-get install -y certbot curl tar && \
        rm -rf /var/lib/apt/lists/* && \
        apt-get clean

ARG GINKGO_WEB_VERSION=1.1.0
ARG GINKGO_WEB_VERSION_PATH=b711b00f3006b99fbc7403609f475eac

RUN curl -L https://git.duniter.org/vjrj/ginkgo/uploads/${GINKGO_WEB_VERSION_PATH}/ginkgo-web-${GINKGO_WEB_VERSION}.tgz | tar xfz - -C /usr/share/nginx/html/ --strip-components=2

COPY nginx.conf.template /etc/nginx/nginx.conf.template

RUN mkdir -p /etc/nginx/snippets && \
    touch /etc/nginx/snippets/proxy-gva.conf && \
    chmod 644 /etc/nginx/snippets/proxy-gva.conf

COPY proxy-gva.conf /etc/nginx/snippets/proxy-gva.conf

# Configuration of g1nkgo
COPY assets/env.production.txt /usr/share/nginx/html/assets/env.production.txt
# In fact this is where flutter looks for it (it seems like a bug)
RUN mkdir -p /usr/share/nginx/html/assets/assets/
COPY assets/env.production.txt /usr/share/nginx/html/assets/assets/env.production.txt

COPY assets/img/ /usr/share/nginx/html/assets/img/

# Copy the default nginx configuration and g1nkgo conf to restore in empty volumes
RUN cp -a /etc/nginx/ /etc/nginx-default/

# Exponer los puertos de nginx
EXPOSE 80
EXPOSE 443

COPY entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
