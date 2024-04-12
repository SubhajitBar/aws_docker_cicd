# Step 1: Build react app
FROM node:alpine3.18 as nodework
WORKDIR /app
COPY package.json .
RUN npm install
COPY . .
RUN npm run build

# Step 2: serve with nginx
FROM nginx:1.23-alpine
WORKDIR /usr/share/nginx/html
RUN rm -rf *
COPY --from=nodework /app/dist .
EXPOSE 80
ENTRYPOINT ["nginx", "-g", "daemon off;"]