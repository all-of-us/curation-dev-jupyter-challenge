FROM alpine:3

# update deps and install bash, curl, and jq packages
RUN apk add --update --no-cache \
    bash \
    curl \
    jq


# copy in our work script
COPY fetch-repos.sh /

# create output directory
RUN mkdir /repos-csv-output

# mark this directory as being the target of a volume
VOLUME [ "/repos-csv-output" ]

# our entrypoint is bash, executing our shell script
ENTRYPOINT [ "/fetch-repos.sh" ]