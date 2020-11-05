FROM swaggerapi/swagger-ui

# override with one that has postgrest
RUN ls /etc/nginx
COPY ./nginx.conf /etc/nginx/

COPY ./launch_pgrest.sh /

ENV POSTGREST_VERSION=v7.0.1

# Install postgrest
COPY postgrest.conf /etc/postgrest.conf
RUN cd /tmp && \
    curl -SLO https://github.com/PostgREST/postgrest/releases/download/${POSTGREST_VERSION}/postgrest-${POSTGREST_VERSION}-linux-x64-static.tar.xz && \
    tar -xJvf postgrest-${POSTGREST_VERSION}-linux-x64-static.tar.xz && \
    mv postgrest /usr/local/bin/postgrest && \
    cd /

ENV PGRST_DB_URI= \
    PGRST_DB_SCHEMA=public \
    PGRST_DB_ANON_ROLE= \
    PGRST_DB_POOL=100 \
    PGRST_DB_EXTRA_SEARCH_PATH=public \
    PGRST_SERVER_HOST=*4 \
    PGRST_SERVER_PORT=3000 \
    PGRST_OPENAPI_SERVER_PROXY_URI= \
    PGRST_JWT_SECRET= \
    PGRST_SECRET_IS_BASE64=false \
    PGRST_JWT_AUD= \
    PGRST_MAX_ROWS= \
    PGRST_PRE_REQUEST= \
    PGRST_ROLE_CLAIM_KEY=".role" \
    PGRST_ROOT_SPEC= \
    PGRST_RAW_MEDIA_TYPES=

# RUN groupadd -g 1000 postgrest && \
#     useradd -r -u 1000 -g postgrest postgrest && \
#     chown postgrest:postgrest /etc/postgrest.conf

# USER 1000

EXPOSE 3000

# WORKDIR /
CMD ["./launch_pgrest.sh"]
# CMD ["sh", "/usr/share/nginx/run.sh"]