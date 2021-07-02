FROM ghcr.io/lolopinto/ent:0.0.17

WORKDIR /app

COPY . .

CMD ["node", "--inspect=0.0.0.0", "dist/graphql/index.js"]
