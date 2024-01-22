FROM ghcr.io/lolopinto/ent:v0.1.17-nodejs-18-dev

WORKDIR /app

COPY . .

CMD ["node", "--inspect=0.0.0.0", "dist/graphql/index.js"]
