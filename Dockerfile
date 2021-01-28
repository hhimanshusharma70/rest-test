

#For React NPM BUild 
FROM node:10-alpine as build-step
RUN mkdir /app
WORKDIR /app
COPY package.json /app
RUN npm config set registry http://registry.npmjs.org/
#RUN npm cache clean
RUN npm install --verbose
COPY . /app
RUN npm run build

#################################################

#COPY . /app


####### For NGINX Build

# Stage 2

FROM nginx:alpine


WORKDIR /usr/share/nginx/html

#RUN rm -rf ./*
COPY --from=build-step  /app/build  /usr/share/nginx/html
#COPY build /usr/share/nginx/html

############## S3 Configuration
#FROM mesosphere/aws-cli
#COPY --from=build-step /app/build
#CMD ["s3", "sync", "./", "s3://test-26-01/rest-test-build"] 