FROM alpine:3

ARG UID=${UID:-1000}
ARG GID=${GID:-1000}

# update deps and install bash, curl, and jq packages
RUN apk add --update --no-cache \
    bash \
    curl \
    jq

# create runtime user group
RUN if ! find . | grep -q ":${GID}:" /etc/group; then \
    addgroup -g ${GID} -S curation; \
    fi;

# create runtime user
RUN adduser \
    -s /usr/bin/bash \
    -S \
    -u "${UID}" \
    -G curation \
    -g "" \
    -H \
    -D \
    curation


# copy in our work script
COPY fetch-repos.sh /
RUN chmod 555 /fetch-repos.sh

# RUN mkdir /repos-csv-output && chown -R curation /repos-csv-output

USER curation

# our entrypoint is bash, executing our shell script
ENTRYPOINT [ "/fetch-repos.sh" ]