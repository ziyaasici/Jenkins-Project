FROM node:14

WORKDIR /usr/src/app

# COPY ./nodejs/server/package*.json ./
COPY ./server/package*.json ./

RUN npm install

# COPY ./nodejs/server/ .
COPY ./server .

EXPOSE 5000

CMD ["node","app.js"]