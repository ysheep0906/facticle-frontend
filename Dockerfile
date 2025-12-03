# 프론트엔드 빌드
FROM node:23 AS builder

WORKDIR /app

COPY package.*json ./

RUN npm install

COPY . .

RUN npm run build


# Nginx 설정
FROM nginx:latest

COPY nginx.conf /etc/nginx/conf.d/default.conf

COPY --from=builder /app/dist /usr/share/nginx/html

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]