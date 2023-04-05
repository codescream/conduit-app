# Stage 1
FROM node:14.20.0-alpine as build
WORKDIR /app
RUN npm install -g @angular/cli
COPY package.json ./
RUN yarn install
ENV PATH /app/node_modules/.bin:$PATH
COPY . ./
RUN npm run build --prod

# Stage 2
FROM nginx:alpine
COPY --from=build /app/dist /usr/share/nginx/html
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
