FROM ghcr.io/lolopinto/ent:0.0.31-nodejs-16-dev
# ghcr.io/lolopinto/ent:0.0.29-nodejs-14-dev
# ghcr.io/lolopinto/ent:0.0.29-nodejs-15-dev

WORKDIR /app

COPY . .

CMD ["node", "--inspect=0.0.0.0", "dist/graphql/index.js"]
