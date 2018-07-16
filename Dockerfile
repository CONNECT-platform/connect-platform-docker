#
# start from Nodejs v8
#
FROM node:8

LABEL maintainer="eugene ghanizadeh khoub <ghanizadeh.eugene@gmail.com>"

#
# obviously, lets work in this simple folder.
#
WORKDIR /app/

#
# lets get the starter boilerplate project
#
RUN git clone https://github.com/loreanvictor/connect-platform-biolerplate.git .

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
