FROM node

RUN apt-get update && apt-get install -y && apt-get clean

RUN mkdir -p /nogeut

COPY . /nogeut

WORKDIR /nogeut

RUN npm install

ENV PORT 3030
EXPOSE 3030

CMD ["node","main.js"]

