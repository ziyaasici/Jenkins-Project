FROM node:14

WORKDIR /usr/src/app

COPY ./server/package*.json ./

RUN npm install

COPY ./server/ .

EXPOSE 5000

CMD ["node","app.js"]
