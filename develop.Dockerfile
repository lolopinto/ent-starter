FROM ghcr.io/lolopinto/ent:0.1.0-alpha.50-nodejs-18-dev

WORKDIR /app

COPY . .

CMD ["node", "--inspect=0.0.0.0", "dist/graphql/index.js"]
