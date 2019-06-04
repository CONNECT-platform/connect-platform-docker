#
# start from Nodejs v8
#
FROM node:8-alpine

LABEL maintainer="eugene ghanizadeh khoub <ghanizadeh.eugene@gmail.com>"

#
# get some basic dependencies.
# - bash and ttyd are used for remote shell access
# - tini for its awesomeness
# - git for getting connect-platform-boilerplate codes
#
RUN apk add --no-cache \
    bash \
    tini \
    ttyd \
    git

#
# obviously, lets work in this simple folder.
#
WORKDIR /app/

#
# lets create the user to work with.
#
RUN addgroup lebowski && adduser -G lebowski -D jeff
RUN chown -R jeff:lebowski /app
RUN chmod g+s /app

#
# also create the logs folder and give jeff the access to them.
#
RUN mkdir /var/log/platform
RUN chown -R jeff:lebowski /var/log/platform

#
# and keep on working as jeff from this point on.
#
USER jeff

#
# for making a clean new build, just increase the version here.
# semver is not particularly applicable to docker images but you
# get the idea on how to control this.
#
# note that this is placed after installing general dependencies
# and setting up the user as it should be mainly used to control
# the connect-platform version.
#
RUN echo "CONNECT platform Dockerfile v 0.1.12"

#
# lets get the starter boilerplate project
#
RUN git clone https://github.com/loreanvictor/connect-platform-boilerplate.git
RUN cp ./connect-platform-boilerplate/index.js .
RUN cp ./connect-platform-boilerplate/package.json .
RUN cp ./connect-platform-boilerplate/nodemon.json .
RUN cp ./connect-platform-boilerplate/run.js .
RUN rm -fr ./connect-platform-boilerplate

#
# also create some necessary folders
#
RUN mkdir ./panel-generated/
RUN mkdir ./secure/
VOLUME /app/panel-generated/
VOLUME /app/secure/

#
# lets now install all dependencies
#
RUN npm install

#
# expose the proper ports
#
EXPOSE 4000

#
# set some default configuration for the platform
#
ENV CONNECT_REMOTE_SHELL_ENABLED=true

#
# start the server
#
ENTRYPOINT ["/sbin/tini", "--"]
CMD ["/bin/sh", "-c", "npm start >>/var/log/platform/out.log 2>>/var/log/platform/err.log"]
