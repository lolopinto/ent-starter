FROM ghcr.io/lolopinto/ent:0.0.12

WORKDIR /app

COPY . /app

CMD ["node", "dist/graphql/index.js"]
