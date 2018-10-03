# Step 1 - Creates React Static Files
FROM node:alpine as build
WORKDIR /client
COPY ./package.*json ./
RUN npm install
COPY . .
RUN npm run build

# Step 2 - Create Nginx with React Static files
FROM nginx
EXPOSE 3000
COPY ./nginx/default.conf /etc/nginx/conf.d/default.conf
COPY --from=build /client/build /usr/share/nginx/html
