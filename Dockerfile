# This is an example of the multi-step builds using 2 images for different purposes
# The FROM command acts as a seperator for both the images
# The nginx is used to serve up the static html files. The compiler looks for the html file in usr/share/nginx/html
# The node image serves as the backbone for the npm command to execute


FROM node:16-alpine AS builder
WORKDIR '/app'
COPY package.json .
RUN npm install
COPY . .
RUN npm run build

FROM nginx
COPY --from=builder /app/build /usr/share/nginx/html
