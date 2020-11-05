FROM registry.access.redhat.com/ubi8/ubi-minimal
ARG CRAN_MIRROR=cran.r-project.org
RUN microdnf install rsync nginx && \
    chmod g+rwx /var/run /var/log/nginx && \
    mkdir /var/cran
COPY whish_list whish_list
RUN printf "\
+ src/\n\
+ src/contrib/\n\
+ src/contrib/PACKAGES\n\
+ src/contrib/Meta\n\
+ src/contrib/Meta/*.rds\n\
" > include; \
    awk "{print \"+ src/contrib/\"\$0\"_*.tar.gz\"}" whish_list >> include; \
    cat include; \
    rsync \
    --verbose --human-readable \
    --times \
    --recursive \
    --delete \
    --copy-links \
    --include-from 'include' \
    --exclude '**' \
    ${CRAN_MIRROR}::CRAN \
    /var/cran/
COPY nginx.conf /etc/nginx/nginx.conf
EXPOSE 8080
USER nginx
ENTRYPOINT [ "nginx", "-g", "daemon off;" ]
