# ent-starter

ensure you have postgres installed

* install [docker](https://docs.docker.com/get-docker/)
* `createdb ent-starter` (replace with name of your app)
* update db credentials in `docker-compose.dev.yml` by changing `DB_CONNECTION_STRING` environment variable
* Enable Github Container Registry for your personal account: https://docs.github.com/en/free-pro-team@latest/packages/getting-started-with-github-container-registry/enabling-improved-container-support
* get a github [personal access token](https://docs.github.com/en/free-pro-team@latest/github/authenticating-to-github/creating-a-personal-access-token)
  - ensure the token has `read:packages` privileges
  - create/edit ~/.npmrc and add this line: `//npm.pkg.github.com/:_authToken={TOKEN}`
  - full details of what's happening here can be found at https://docs.github.com/en/free-pro-team@latest/packages/using-github-packages-with-your-projects-ecosystem/configuring-npm-for-use-with-github-packages#authenticating-with-a-personal-access-token
  - Login to github's docker container registry as follows: `echo "{TOKEN}" | docker login ghcr.io -u USERNAME --password-stdin`
  - full details of what's happening here: https://docs.github.com/en/free-pro-team@latest/packages/managing-container-images-with-github-container-registry/pushing-and-pulling-docker-images#authenticating-to-github-container-registry
* run `npm install`
- run `npm run codegen` after making any changes to the schema
* Make sure to run `npm run compile` after making any changes to the code and before running `npm start`

Example schema change:

```ts
// src/schema/user.ts
// this adds a User object with a firstName and lastName
import { BaseEntSchema, Field, StringType } from "@lolopinto/ent";

export default class User extends BaseEntSchema {
  fields: Field[] = [
    StringType({ name: "FirstName" }),
    StringType({ name: "LastName" }),
  ];
}
```

### upgrading base image
Note that when the base image is changed, e.g. when upgrading the ent package tag, you should rebuild the image as follows: `docker-compose -f docker-compose.dev.yml build` or `docker-compose -f docker-compose.dev.yml up --build` so as to not be stuck with an old image and not see the changes from the new version.

A list of available images can be seen by running the following command: `docker image ls`. If you see an image with repository `{container-name}_app` e.g. `ent-starter_app` that's from a couple weeks or months ago after upgrading the base image, that's the issue you're running into.
