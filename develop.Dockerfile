FROM ghcr.io/lolopinto/ent:v0.1.14-nodejs-18-slim

WORKDIR /app

COPY . .

CMD ["node", "--inspect=0.0.0.0", "dist/graphql/index.js"]
