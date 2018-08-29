#
# start from Nodejs v8
#
FROM node:8

LABEL maintainer="eugene ghanizadeh khoub <ghanizadeh.eugene@gmail.com>"

#
# for making a clean new build, just increase the version here.
# semver is not particularly applicable to docker images but you
# get the idea on how to control this.
#
RUN echo "CONNECT platform Dockerfile v 0.1.5"

#
# obviously, lets work in this simple folder.
#
WORKDIR /app/

#
# lets get the starter boilerplate project
#
RUN git clone https://github.com/loreanvictor/connect-platform-boilerplate.git
RUN cp ./connect-platform-boilerplate/index.js .
RUN cp ./connect-platform-boilerplate/package.json .
RUN cp ./connect-platform-boilerplate/nodemon.json .
RUN rm -fr ./connect-platform-boilerplate

#
# lets now install all dependencies
#
RUN npm install

#
# expose the proper port
#
EXPOSE 4000

#
# start the server
#
CMD ["npm", "start"]
