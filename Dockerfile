FROM node:10-alpine as build-step

#RUN npm i npm@latest -g

# install dependencies first, in a different location for easier app bind mounting for local development
# due to default /opt permissions we have to create the dir with root and change perms
RUN mkdir /opt/node_app && chown node:node /opt/node_app
WORKDIR /opt/node_app
# the official node image provides an unprivileged user as a security best practice
# but we have to manually enable it. We put it here so npm installs dependencies as the same
# user who runs the app. 
# https://github.com/nodejs/docker-node/blob/master/docs/BestPractices.md#non-root-user
USER node
COPY package.json package-lock.json* ./
RUN npm install --no-optional && npm cache clean --force
ENV PATH /opt/node_app/node_modules/.bin:$PATH

# check every 30s to ensure this service returns HTTP 200
HEALTHCHECK --interval=30s CMD node healthcheck.js

# copy in our source code last, as it changes the most
WORKDIR /opt/node_app/app
COPY . .

RUN npm run build

#################################################

#COPY . /app


####### For NGINX Build

# Stage 2

FROM nginx:alpine


WORKDIR /usr/share/nginx/html

#RUN rm -rf ./*
COPY --from=build-step  /opt/node_app/app/build  /usr/share/nginx/html
#COPY build /usr/share/nginx/html

############## S3 Configuration
#FROM mesosphere/aws-cli
#COPY --from=build-step /app/build
#CMD ["s3", "sync", "./", "s3://test-26-01/rest-test-build"] 