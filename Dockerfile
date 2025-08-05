FROM node:18-alpine AS builder
WORKDIR /app
COPY ./index.html /app/src/
RUN npm install -g html-minifier-terser
RUN mkdir dist && \
    html-minifier-terser --input-dir src --output-dir dist \
    --collapse-whitespace --remove-comments --minify-css true --minify-js true

# ---------- Stage 2: Serve with Nginx ----------
#FROM nginx:alpine
#COPY --from=builder /app/dist /usr/share/nginx/html
#EXPOSE 80
FROM nginx:alpine
COPY src/ /usr/share/nginx/html
EXPOSE 80
