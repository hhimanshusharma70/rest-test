
FROM node:10-alpine as build-step
RUN mkdir /app

WORKDIR /app

COPY package.json /app

RUN npm install

COPY . /app

RUN npm run build

# Stage 2

FROM nginx:alpine
WORKDIR /usr/share/nginx/html

# Remove default nginx static assets
RUN rm -rf ./*
COPY --from=build-step  /app/build  /usr/share/nginx/html

#FROM mesosphere/aws-cli

#Using the alias defined for the first container, copy the contents of the build folder to this container
#COPY --from=build-step /app/build

#Set the default command of this container to push the files from the working directory of this container to our s3 bucket 
#CMD ["s3", "sync", "./", "s3://test-26-01/rest-test-build"] 