# ent-starter

Prerequisites:

* Ensure you're logged in to Github and then click "Use this template" to create your own instance of the repository. And then clone your copy of the repository to your local machine to make changes.
* Install [Docker](https://docs.docker.com/get-docker/)
* Install [Node 14](https://nodejs.org/en/download/) or more recent version.

## upgrading base image

There are periodic updates to the base image as more functionality is added to the framework.

Anytime the base image changes (compare the top line in `develop.Dockerfile` in the repository to your copy ), you should rebuild the image by running `npm run rebuild-image` so as to not be stuck with an old image and not see the changes from the new version.

A list of available images can be seen by running the following command: `docker image ls`. If you see an image with repository `{container-name}_app` e.g. `ent-starter_app` that's from a couple weeks or months ago after upgrading the base image, that's the issue you're running into.

## database options

There are 3 different supported ways to store data:

* [local postgres database](#local-postgres-database)
* [postgres docker image](#postgres-docker-image)
* [sqlite](#sqlite)

### local postgres database

* Run `createdb ent-starter` (replace with name of your app) to create your database
* update db credentials in file `docker-compose.dev.yml` by changing `DB_CONNECTION_STRING` environment variable
* Run `npm install` to install dependencies
* Run `npm run codegen` after making any changes to the schema
* Make sure to run `npm run compile` after making any changes to the code and before running `npm start`

Example schema change:

```ts
// src/schema/user.ts
// this adds a User object with a firstName and lastName
import { BaseEntSchema, Field, StringType } from "@snowtop/ent";

export default class User extends BaseEntSchema {
  fields: Field[] = [
    StringType({ name: "FirstName" }),
    StringType({ name: "LastName" }),
  ];
}
```

For a full intro, check out the [docs](https://ent.dev/docs/intro#your-first-schema).

### postgres docker image

Instead of installing Postgres and having to deal with a local install, you can use the `postgres` image. Follow these steps to get started:

* uncomment out the section in `docker-compose-dev.yml` referring to the `db` service. Note that indentation in `yml` files matters.
* change the `DB_CONNECTION_STRING` line in the environment section of the `app` service to `DB_CONNECTION_STRING=postgres://postgres:postgres@db/ent-starter` (or name of your app)
* if you used a different database, update `POSTGRES_DB` environment variable to database
* if you changed your project name, update `container_name` to `name_of_project`
* update `.gitignore` to add `postgres_data` so as to not check in the postgres files.
* Add `psql` as a script to the `scripts` section of `package.json` with value `docker-compose -f docker-compose.dev.yml run --rm db psql ent-starter -h db -U postgres` to make it easy to query the database.
* Add `background` as a script to the `scripts` section of `package.json` with value `docker-compose -f docker-compose.dev.yml up -d` to run in [detached mode](https://docs.docker.com/compose/reference/up/) since some of the commands require the database to be available and listening to connections before they can succeed.
* Run `npm run background` to start the database in the background.
* Run `npm install` to install dependencies
* Run `npm run psql` to connect to database. Seems to be required to have the connection to database consistently work.
* Run `npm run codegen` after making any changes to the schema
* Make sure to run `npm run compile` after making any changes to the code and before running `npm start`

Example schema change:

```ts
// src/schema/user.ts
// this adds a User object with a firstName and lastName
import { BaseEntSchema, Field, StringType } from "@snowtop/ent";

export default class User extends BaseEntSchema {
  fields: Field[] = [
    StringType({ name: "FirstName" }),
    StringType({ name: "LastName" }),
  ];
}
```

When done, run `docker container ls | grep ent-starter  | cut -d " " -f 1 | xargs docker stop` to stop all containers.

### sqlite support

* Need to run `npm install better-sqlite3` to install sqlite dependency.
* Add `sqlite-init` to the `scripts` section of package.json with value `rm -rf node_modules && docker-compose -f docker-compose.dev.yml run --rm app npm install`
* Run `npm run sqlite-init` to initialize things/install dependencies. Anytime a new dependency is added, have to run `npm run sqlite-init` to install in the container.
* change the `DB_CONNECTION_STRING` line in the environment section of the `app` service to `DB_CONNECTION_STRING=sqlite:///ent-starter.db`
* Run `npm run codegen` after making any changes to the schema
* Make sure to run `npm run compile` after making any changes to the code and before running `npm start`

Example schema change:

```ts
// src/schema/user.ts
// this adds a User object with a firstName and lastName
import { BaseEntSchema, Field, StringType } from "@snowtop/ent";

export default class User extends BaseEntSchema {
  fields: Field[] = [
    StringType({ name: "FirstName" }),
    StringType({ name: "LastName" }),
  ];
}
```
