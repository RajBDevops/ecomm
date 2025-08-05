FROM node:18-alpine AS builder
WORKDIR /app
COPY . .
RUN npm install -g html-minifier-terser
RUN mkdir dist && \
    html-minifier-terser --input-dir src --output-dir dist \
    --file-ext html \
    --collapse-whitespace --remove-comments --minify-css true --minify-js true \
    cp -r css fonts img js scss dist/ 2>/dev/null || true
# ---------- Stage 2: Serve with Nginx ----------
FROM nginx:alpine
#COPY --from=builder /app/dist /usr/share/nginx/html

COPY . /usr/share/nginx/html

EXPOSE 80

