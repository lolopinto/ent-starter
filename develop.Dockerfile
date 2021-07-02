FROM ghcr.io/lolopinto/ent:0.0.18-nodejs-16
# ghcr.io/lolopinto/ent:0.0.18-nodejs-14
# ghcr.io/lolopinto/ent:0.0.18-nodejs-15

WORKDIR /app

COPY . .

CMD ["node", "--inspect=0.0.0.0", "dist/graphql/index.js"]
