FROM node:16.14 as build
WORKDIR /app
COPY . ./
RUN npm install
RUN npm run build --outDir /app/build
# Stage 2 - Production Environment
FROM nginx:alpine
WORKDIR /usr/share/nginx/html
COPY --from=build /app/build .
COPY nginx.conf /etc/nginx/conf.d/default.conf
EXPOSE 8080
CMD ["nginx", "-g", "daemon off;"]


