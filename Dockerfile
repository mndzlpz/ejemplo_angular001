# build

FROM node:alpine AS angular_build
WORKDIR /app
COPY package.json ./
RUN npm install
COPY . .
RUN npm run build --prod
RUN ifconfig

# run

FROM nginx:alpine AS angular-run
COPY --from=angular_build /app/dist/app-new /usr/share/nginx/html
EXPOSE 80
CMD ["nginx","-g","daemon off;"]
RUN ifconfig