
FROM node:13.12.0-alpine as build-step
RUN mkdir /app

WORKDIR /app


COPY package.json /app

RUN npm config set registry http://registry.npmjs.org/

RUN npm install --verbose

COPY . /app

RUN npm run build



# Stage 2

FROM nginx:alpine
WORKDIR /usr/share/nginx/html

#RUN rm -rf ./*
COPY --from=build-step  /app/build  /usr/share/nginx/html

#FROM mesosphere/aws-cli
#COPY --from=build-step /app/build
#CMD ["s3", "sync", "./", "s3://test-26-01/rest-test-build"] 