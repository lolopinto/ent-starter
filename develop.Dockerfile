FROM ghcr.io/lolopinto/ent:0.0.35-nodejs-17-dev
# ghcr.io/lolopinto/ent:0.0.35-nodejs-14-dev
# ghcr.io/lolopinto/ent:0.0.35-nodejs-16-dev

WORKDIR /app

COPY . .

CMD ["node", "--inspect=0.0.0.0", "dist/graphql/index.js"]
