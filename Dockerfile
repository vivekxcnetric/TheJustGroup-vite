# Stage 1 - Build

FROM node:16.14 as build

WORKDIR /app

COPY . ./

RUN npm install

RUN npm run build --outDir ./dist
 
# Stage 2 - Production Environment

FROM nginx:alpine

COPY --from=build /app/dist /usr/share/nginx/html

COPY nginx.conf /etc/nginx/conf.d/default.conf

EXPOSE 8080

CMD ["nginx", "-g", "daemon off;"]