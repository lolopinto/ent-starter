FROM ghcr.io/lolopinto/ent:0.0.10

WORKDIR /app

COPY . /app

CMD ["node", "dist/graphql/index.js"]
