FROM ghcr.io/lolopinto/ent:0.0.1

WORKDIR /app

COPY . /app

CMD ["node", "dist/graphql/index.js"]