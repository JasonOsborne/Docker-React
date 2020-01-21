FROM node:alpine as builder
WORKDIR '/app'
COPY package.json .
RUN npm install
COPY . .
RUN npm run build

# /app/build <== contains all the stuff for the build

FROM nginx
EXPOSE 80
# copying from specified phase to specified path to another specified path
COPY --from=builder /app/build /usr/share/nginx/html