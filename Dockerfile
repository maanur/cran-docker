FROM registry.access.redhat.com/ubi8/ubi-minimal
ARG CRAN_MIRROR=cran.r-project.org
RUN microdnf install rsync nginx && \
    mkdir /var/cran
RUN rsync \
    --verbose --human-readable \
    --times \
    --recursive \
    --delete \
    --copy-links \
    --include 'src/'\
    --include 'src/contrib/' \
    --include 'src/contrib/*.tar.gz' \
    --include 'src/contrib/PACKAGES*' \
    --include 'src/contrib/Meta/' \
    --include 'src/contrib/Meta/*.rds' \
    --exclude '**' \
    ${CRAN_MIRROR}::CRAN \
    /var/cran/
COPY nginx.conf /etc/nginx/nginx.conf
EXPOSE 8080
ENTRYPOINT [ "nginx", "-g", "daemon off;" ]
